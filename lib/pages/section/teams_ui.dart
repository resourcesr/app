import "package:flutter/material.dart";
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/list_header.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamsUi extends StatelessWidget {
  _openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Teams"),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListHeader(title: "Core"),
            ListTile(
              leading: ImageAvatar(
                  "https://avatars0.githubusercontent.com/u/27757785?v=4"),
              title: Text("Muhammad Umer Farooq"),
              subtitle: Text("Lead Developer"),
              onTap: () => {
                _openUrl("https://github.com/lablnet"),
              },
            ),
            ListTile(
              leading: ImageAvatar(
                  "https://avatars0.githubusercontent.com/u/63644818?v=4"),
              title: Text("Usman Naeem"),
              subtitle: Text("Graphic Designer"),
              onTap: () => {
                _openUrl("https://github.com/Usman-Naeem"),
              },
            ),
          ],
        ),
      ),
    );
  }
}
