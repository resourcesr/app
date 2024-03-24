import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resourcesr/models/NotificationManager.dart';

class PushNotifications {
  PushNotifications._();

  // Create self instance of class.
  factory PushNotifications() => _instance;
  static final PushNotifications _instance = PushNotifications._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  // Sub for notification
  void _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
  }

  Future<void> init() async {
    if (!_initialized) {
      // Initialize Firebase
      await Firebase.initializeApp();

      _registerOnFirebase();

      // Request notification permissions for iOS

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        NotificationManager().sendNotification(
            message.notification!.title ?? "",
            message.notification!.body ?? "");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        NotificationManager().sendNotification(
            message.notification!.title ?? "",
            message.notification!.body ?? "");
      });

      // For testing print the Messaging token
      //String token = await _firebaseMessaging.getToken();
      //print("token: $token");

      _initialized = true;
    }
  }
}
