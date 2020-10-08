import "package:flutter/material.dart";
import 'package:riphahwebresources/pages/downlaod_ui.dart';
import 'package:riphahwebresources/pages/section/about_ui.dart';
import 'package:riphahwebresources/pages/section/developer_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

_openUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

List<Widget> menu(context) {
  List<Widget> childrens = [];
  childrens.add(
    ListTile(
      leading: Icon(Icons.download_rounded),
      title: Text("My Downloads"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DownloadUi()))
      },
    ),
  );
  childrens.add(
    ListTile(
      leading: Icon(Icons.security),
      title: Text("Privacy Policy"),
      onTap: () => {
        _openUrl("http://resourcesr.web.app/privacy"),
      },
    ),
  );
  childrens.add(
    ListTile(
      leading: Icon(Icons.share),
      title: Text("Share app"),
      onTap: () => {
        Share.share(
            "Hi, checkout this ResourcesR app https://resourcesr.web.app/")
      },
    ),
  );
  childrens.add(
    ListTile(
      leading: Icon(Icons.info),
      title: Text("About App"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutUi()))
      },
    ),
  );
  childrens.add(
    ListTile(
      leading: Icon(Icons.developer_board),
      title: Text("Developers"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DeveloperUi()))
      },
    ),
  );
  childrens.add(ListTile(
    leading: Icon(Icons.code),
    title: Text("Source Code"),
    onTap: () => {
      _openUrl("https://github.com/resourcesr/app"),
    },
  ));
  return childrens;
}
