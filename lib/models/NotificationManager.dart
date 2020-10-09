import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  NotificationManager() {
    init();
  }
  void init() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: (String payload) async {});
  }

  prepareNotification(String title, String body, String payload) {
    // Android specific
    var androidChannelSpecifics = AndroidNotificationDetails(
      // Todo generate ID.
      "122",
      title,
      body,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    // IOS specific
    var iosChannelSpecifics = IOSNotificationDetails();
    // Config platform specific.
    return NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
  }

  Future<void> sendNotification(String title, String body,
      {String payload = ""}) async {
    print("test");
    // Fire notification
    await FlutterLocalNotificationsPlugin().show(
      // Todo generate ID.
      12, // Notification ID
      title, // Notification Title
      body, // Notification Body, set as null to remove the body
      prepareNotification(title, body, payload),
      payload: payload, // Notification Payload
    );
  }

  scheduleNotification(String title, String body, {String payload = ""}) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("America/Detroit"));

    // Fire notification
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      // Todo generate ID.
      12,
      title,
      body,
      // Todo change the time to accpet from method param.
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      prepareNotification(title, body, payload),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
