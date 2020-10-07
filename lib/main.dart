import 'package:riphahwebresources/config.dart';
import 'package:riphahwebresources/data/PushNotification.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/dashboard_ui.dart';
import 'package:riphahwebresources/pages/klasses_ui.dart';
import "package:flutter/material.dart";
import './theme.dart';
import 'data/User.dart';
import './config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String uid = "";
  try {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? "";
  } catch (_) {}
  runApp(WebResourceApp(uid));
}

class WebResourceApp extends StatefulWidget {
  WebResourceApp(this.uid);
  final String uid;
  //WebResourceApp({Key key}) : super(key: key);
  @override
  _WebResourceAppState createState() => _WebResourceAppState();
}

class _WebResourceAppState extends State<WebResourceApp> {
  User user;
  @override
  void initState() {
    PushNotifications().init();
    currentTheme.addListener(() {
      setState(() {});
    });
    user = User(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: user.status == AccountStatus.Success ? DashboardUi(user) : HomeUi(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: currentTheme.currentTheme(),
      routes: {
        '/classes': (context) => KlassesUi(dep: "fc"),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
