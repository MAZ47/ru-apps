/// Local notification scheduling (Flutter local_notifications). The
/// public API is kept small — schedule a single reminder, cancel one,
/// or cancel all. Backend FCM delivery is handled in [FirebaseService].
library;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  bool _initialized = false;
  bool _enabled = true;

  /// Whether the user has push notifications turned on.
  bool get enabled => _enabled;

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    if (!value) await cancelAll();
    // TODO(notifications): persist (e.g. SharedPreferences) and
    // subscribe/unsubscribe the FCM topic here.
  }

  Future<void> initialize() async {
    if (_initialized) return;
    // TODO(notifications): wire up FlutterLocalNotificationsPlugin here.
    _initialized = true;
  }

  Future<void> showLocal({required String title, required String body}) async {
    if (!_initialized || !_enabled) return;
    // TODO(notifications): FlutterLocalNotificationsPlugin.show(...);
  }

  Future<void> cancel(int id) async {
    if (!_initialized) return;
    // TODO(notifications): FlutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAll() async {
    if (!_initialized) return;
    // TODO(notifications): FlutterLocalNotificationsPlugin.cancelAll();
  }
}