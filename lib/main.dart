import 'package:riphahwebresources/config.dart';
import 'package:riphahwebresources/data/PushNotification.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/dashboard_ui.dart';
import 'package:riphahwebresources/pages/klasses_ui.dart';
import "package:flutter/material.dart";
import './theme.dart';
import 'data/User.dart';
import 'package:provider/provider.dart';
import './config.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: WebResourceApp(),
    ),
  );
}

class WebResourceApp extends StatefulWidget {
  WebResourceApp({Key key}) : super(key: key);
  @override
  _WebResourceAppState createState() => _WebResourceAppState();
}

class _WebResourceAppState extends State<WebResourceApp> {
  User user = User();
  @override
  void initState() {
    PushNotifications().init();
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: user.loggedIn ? DashboardUi(user) : HomeUi(),
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
