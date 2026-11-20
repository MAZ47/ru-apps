/// Thin facade over Firebase Cloud Messaging. Real configuration is
/// pending; the public surface stays the same so screens can already
/// subscribe / unsubscribe without crashing on a missing plugin.
///
/// Activate it once `firebase_core` and `firebase_messaging` are added:
///   await Firebase.initializeApp();
///   final token = await FirebaseMessaging.instance.getToken();
library;

class FirebaseService {
  FirebaseService();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    // TODO(firebase): call Firebase.initializeApp() once the project is wired.
    _initialized = true;
  }

  /// Returns the FCM registration token. Null until Firebase is initialized.
  Future<String?> getDeviceToken() async {
    if (!_initialized) return null;
    // TODO(firebase): return FirebaseMessaging.instance.getToken();
    return null;
  }

  /// Subscribes the device to a topic (e.g. 'notices', 'events').
  Future<void> subscribeToTopic(String topic) async {
    if (!_initialized) return;
    // TODO(firebase): FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    if (!_initialized) return;
    // TODO(firebase): FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}