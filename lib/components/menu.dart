import "package:flutter/material.dart";
import 'package:resourcesr/pages/downlaod_ui.dart';
import 'package:resourcesr/pages/feedback_ui.dart';
import 'package:resourcesr/pages/section/about_ui.dart';
import 'package:resourcesr/pages/section/contributers_ui.dart';
import 'package:resourcesr/utils/url.dart';
import 'package:share/share.dart';

List<Widget> menu(context) {
  List<Widget> childrens = [];
  childrens.addAll([
    ListTile(
      leading: Icon(Icons.download_rounded),
      title: Text("My Downloads"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DownloadUi()))
      },
    ),
    ListTile(
      leading: Icon(Icons.contact_mail),
      title: Text("Feedback"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FeedbackUi()))
      },
    ),
    ListTile(
      leading: Icon(Icons.security),
      title: Text("Privacy Policy"),
      onTap: () => {
        openUrl("http://resourcesr.web.app/privacy"),
      },
    ),
    ListTile(
      leading: Icon(Icons.share),
      title: Text("Share app"),
      onTap: () => {
        Share.share(
            "Hi, checkout this ResourcesR app https://resourcesr.web.app/")
      },
    ),
    ListTile(
      leading: Icon(Icons.info),
      title: Text("About App"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUi()))
      },
    ),
    ListTile(
      leading: Icon(Icons.developer_board),
      title: Text("Contributors"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContributersUi()))
      },
    ),
    ListTile(
      leading: Icon(Icons.code),
      title: Text("Source Code"),
      onTap: () => {
        openUrl("https://github.com/resourcesr/app"),
      },
    ),
  ]);

  return childrens;
}
