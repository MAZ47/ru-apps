/// Cache layer backed by `shared_preferences`. Use for short-lived keys
/// (auth tokens, settings, last-fetched timestamps). Heavy payloads should
/// go to a file or sqflite.
library;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  CacheService._(this._prefs);
  final SharedPreferences _prefs;

  static Future<CacheService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return CacheService._(prefs);
  }

  // ---- String / primitive helpers ----
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clear() => _prefs.clear();

  // ---- JSON helpers ----
  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      setString(key, jsonEncode(value));
  Map<String, dynamic>? getJson(String key) {
    final raw = getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {}
    return null;
  }
}