/// Provider wrapper around [AuthService]. Screens watch [isAuthenticated],
/// [currentUser], and [loginState] rather than calling the service directly.
library;

import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._service);
  final AuthService _service;

  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _errorMessage;
  bool _busy = false;

  AuthStatus get status => _status;
  UserModel? get currentUser => _user;
  String? get errorMessage => _errorMessage;
  bool get busy => _busy;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<void> bootstrap() async {
    // TODO(api): try to refresh a stored token here. For now we treat the
    // app as signed-out until the user explicitly logs in.
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> login({
    required String usernameOrId,
    required String password,
    String scope = 'student_services',
  }) async {
    _busy = true;
    _errorMessage = null;
    notifyListeners();
    final result = await _service.login(
      usernameOrId: usernameOrId,
      password: password,
    );
    _busy = false;
    if (!result.success) {
      _errorMessage = result.errorMessage;
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
    _user = result.user;
    _status = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await _service.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
