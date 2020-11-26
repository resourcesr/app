import "package:flutter/material.dart";
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/list_header.dart';

class AboutUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "About"),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListHeader(title: "App"),
            ListTile(
              title: Text("ResourcesR"),
              subtitle: Text("Version: 1.3.1"),
            ),
            ListTile(
              title: Text("Copyright"),
              subtitle: Text("2020 - 2024 Muhammad Umer Farooq"),
            ),
            ListTile(
              title: Text("License"),
              subtitle: Text("GNU GPL 3"),
            ),
            ListHeader(title: "Flutter"),
            ListTile(
              title: Text("Flutter version"),
              subtitle: Text("1.24.0"),
            ),
            ListTile(
              title: Text("SDK Channel"),
              subtitle: Text("Beta"),
            ),
            ListTile(
              title: Text("Dark SDK version"),
              subtitle: Text("2.10.4"),
            ),
          ],
        ),
      ),
    );
  }
}
