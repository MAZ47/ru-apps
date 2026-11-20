/// Provider for user preferences. Persists to [CacheService] so settings
/// survive app restarts.
library;

import 'package:flutter/foundation.dart';

import '../services/cache_service.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider(this._cache);
  final CacheService _cache;

  static const _pushKey = 'settings.push_notifications';

  bool _pushNotifications = true;
  bool get pushNotifications => _pushNotifications;

  Future<void> bootstrap() async {
    final stored = _cache.getBool(_pushKey);
    if (stored != null) _pushNotifications = stored;
    notifyListeners();
  }

  Future<void> setPushNotifications(bool value) async {
    _pushNotifications = value;
    await _cache.setBool(_pushKey, value);
    notifyListeners();
  }
}
