import "package:flutter/material.dart";
import 'package:riphahwebresources/config.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    elevation: 0.5,
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.wb_sunny),
        onPressed: () => {
          currentTheme.switchTheme(),
        },
      )
    ],
  );
}
