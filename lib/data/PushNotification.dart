import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  PushNotifications._();

  factory PushNotifications() => _instance;

  static final PushNotifications _instance = PushNotifications._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS required premission.
      _firebaseMessaging.requestNotificationPermissions();

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

      _initialized = false;
    }
  }
}
