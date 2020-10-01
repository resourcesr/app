import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/klasses_ui.dart';
import "package:flutter/material.dart";
import './theme.dart';
import 'data/User.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: WebResourceApp(),
    ),
  );
  //runApp(WebResourceApp());
}

class WebResourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeUi(),
        theme: lightTheme(),
        darkTheme: darkTheme(),
        routes: {
          '/classes': (context) => KlassesUi(dep: "fc"),
        });
  }
}
