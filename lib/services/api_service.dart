/// Thin wrapper over `package:http` so screens/providers don't import HTTP
/// directly. Auth tokens are attached by [AuthService] before each call.
library;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_endpoints.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);
  @override
  String toString() => 'ApiException($statusCode): $message';
}

typedef TokenProvider = Future<String?> Function();

class ApiService {
  ApiService({http.Client? client, TokenProvider? tokenProvider})
      : _client = client ?? http.Client(),
        _tokenProvider = tokenProvider;

  final http.Client _client;
  TokenProvider? _tokenProvider;

  void setTokenProvider(TokenProvider provider) => _tokenProvider = provider;

  Map<String, String> _headers(String? token, {bool json = true}) => {
        if (json) 'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  dynamic _decode(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    }
    throw ApiException(res.statusCode, res.body);
  }

  Future<dynamic> get(String url) async {
    final token = await _tokenProvider?.call();
    final res = await _client.get(Uri.parse(url), headers: _headers(token));
    return _decode(res);
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final token = await _tokenProvider?.call();
    final res = await _client.post(
      Uri.parse(url),
      headers: _headers(token),
      body: jsonEncode(body),
    );
    return _decode(res);
  }

  // Convenience helpers keyed by our endpoint table.
  Future<dynamic> login(Map<String, dynamic> body) =>
      post(ApiEndpoints.authLogin, body);
  Future<dynamic> refresh(String refreshToken) =>
      post(ApiEndpoints.authRefresh, {'refresh_token': refreshToken});
  Future<dynamic> logout() => post(ApiEndpoints.authLogout, const {});

  Future<dynamic> libraryCatalog({String? query}) =>
      get('${ApiEndpoints.libraryCatalog}?q=${Uri.encodeQueryComponent(query ?? '')}');
  Future<dynamic> libraryBorrowed() => get(ApiEndpoints.libraryBorrowed);

  Future<dynamic> medicalRecords() => get(ApiEndpoints.medicalRecords);

  Future<dynamic> studentProfile() => get(ApiEndpoints.studentProfile);
  Future<dynamic> studentCourses() => get(ApiEndpoints.studentCourses);
  Future<dynamic> studentResults() => get(ApiEndpoints.studentResults);

  Future<dynamic> webmailInbox() => get(ApiEndpoints.webmailInbox);

  void dispose() => _client.close();
}