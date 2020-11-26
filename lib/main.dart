import "package:flutter/material.dart";
import 'package:resourcesr/config.dart';
import 'package:resourcesr/data/Downloader.dart';
import 'package:resourcesr/data/PushNotification.dart';
import 'package:resourcesr/pages/Home/home_ui.dart';
import 'package:resourcesr/pages/dashboard_splash_ui.dart';
import 'package:resourcesr/pages/Courses/klasses_ui.dart';
import './theme.dart';
import 'data/User.dart';
import './config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  String uid = "";
  bool theme = false;

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Downloader().init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? "";
    theme = prefs.getBool('theme') ?? false;
  } catch (_) {}

  runApp(WebResourceApp(uid, theme));
}

class WebResourceApp extends StatefulWidget {
  WebResourceApp(this.uid, this.theme);
  final String uid;
  final bool theme;

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
      home: user.status == AccountStatus.Success
          ? DashboardSplashUi(user: user)
          : HomeUi(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: currentTheme.currentTheme(theme: widget.theme),
      routes: {
        '/classes': (context) => KlassesUi(dep: "fc"),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
