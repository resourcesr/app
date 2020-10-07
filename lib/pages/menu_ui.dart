import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';
import 'package:riphahwebresources/pages/auth/profile_ui.dart';
import 'package:riphahwebresources/pages/downlaod_ui.dart';
import 'package:riphahwebresources/pages/section/about_ui.dart';
import 'package:riphahwebresources/pages/section/developer_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MenuUi extends StatefulWidget {
  MenuUi({this.user});
  User user;
  @override
  _MenuUiState createState() => _MenuUiState();
}

class _MenuUiState extends State<MenuUi> {
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
      appBar: customAppBar(context, "Menu", back: false),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              leading: TextAvatar(text: widget.user.name ?? "Your Name"),
              title: Text(widget.user.name ?? "Your Name"),
              subtitle: Text(widget.user.role ?? "Your Status"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Profile"),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUi(
                              user: widget.user,
                            )))
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => {
                widget.user.logout(),
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeUi()))
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.offline_pin),
              title: Text("My Downloads"),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DownloadUi()))
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Privacy Policy"),
              onTap: () => {
                _openUrl("http://resourcesr.web.app/privacy"),
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
              title: Text("Developers"),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DeveloperUi()))
              },
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text("Source Code"),
              onTap: () => {
                _openUrl("https://github.com/resourcesr/app"),
              },
            )
          ],
        ),
      ),
    );
  }
}
