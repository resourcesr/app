import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:package_info/package_info.dart';

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
              subtitle: Text("Version: 1.0.0"),
            ),
            ListTile(
              title: Text("Copyright"),
              subtitle: Text("20 20 - 2024 Muhammad Umer Farooq"),
            ),
            ListTile(
              title: Text("License"),
              subtitle: Text("GNU GPL 3"),
            ),
            ListHeader(title: "Flutter"),
            ListTile(
              title: Text("Flutter version"),
              subtitle: Text("1.22.0"),
            ),
            ListTile(
              title: Text("SDK Channel"),
              subtitle: Text("Master"),
            ),
            ListTile(
              title: Text("Dark SDK version"),
              subtitle: Text("xxx"),
            ),
          ],
        ),
      ),
    );
  }
}
