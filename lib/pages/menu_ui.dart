import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/menu.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/auth/profile_ui.dart';

class MenuUi extends StatefulWidget {
  MenuUi({this.user});
  User user;
  @override
  _MenuUiState createState() => _MenuUiState();
}

class _MenuUiState extends State<MenuUi> {
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
            ...menu(context)
          ],
        ),
      ),
    );
  }
}
