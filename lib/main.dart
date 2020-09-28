import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/klasses_ui.dart';
import "package:flutter/material.dart";
import './theme.dart';

void main() {
  runApp(WebResourceApp());
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
