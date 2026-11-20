/// Auth orchestration. Holds the [ApiService] reference, exposes a
/// [TokenProvider] so HTTP calls can attach `Authorization: Bearer …`.
///
/// Real backend integration is pending ru.ac.bd; the methods return a
/// clean shape ([AuthResult]) so the UI can stay unchanged when the
/// backend is wired up.
library;

import '../models/user_model.dart';
import 'api_service.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;
  final UserModel? user;
  final String? token;

  const AuthResult({required this.success, this.errorMessage, this.user, this.token});
}

class AuthService {
  AuthService(this._api);

  // ignore: unused_field
  final ApiService _api;

  UserModel? _currentUser;
  String? _token;

  UserModel? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _token != null && _currentUser != null;

  /// Provider plugged into [ApiService] so each request can attach the
  /// current token. Returns the latest known token (may be null when
  /// the user is signed out).
  Future<String?> tokenProvider() async => _token;

  /// Stubbed login. Once the real backend exists we'll swap the body for
  /// [_api.login] and map the response into [AuthResult].
  Future<AuthResult> login({
    required String usernameOrId,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // TODO(api): replace with `_api.login({'username': ..., 'password': ...})`
    // and parse the real response.
    if (usernameOrId.trim().isEmpty || password.length < 6) {
      return const AuthResult(success: false, errorMessage: 'Invalid credentials. Please try again.');
    }
    _token = 'mock-token-${DateTime.now().millisecondsSinceEpoch}';
    _currentUser = UserModel(
      id: '1',
      name: 'Anika Rahman',
      email: '$usernameOrId@ru.ac.bd',
      studentId: usernameOrId,
      role: 'student',
      department: 'Computer Science & Engineering',
      faculty: 'Engineering',
    );
    return AuthResult(success: true, user: _currentUser, token: _token);
  }

  Future<void> logout() async {
    // TODO(api): _api.logout()
    _token = null;
    _currentUser = null;
  }
}