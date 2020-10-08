import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  PushNotifications._();

  // Create self instance of class.
  factory PushNotifications() => _instance;
  static final PushNotifications _instance = PushNotifications._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  // Sub for notification
  void _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
  }

  Future<void> init() async {
    if (!_initialized) {
      _registerOnFirebase();
      // For iOS required premission.
      _firebaseMessaging.requestNotificationPermissions();

      // Let's configure it.
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );

      // For testing print the Messaging token
      String token = await _firebaseMessaging.getToken();
      print("token: $token");

      _initialized = true;
    }
  }
}
