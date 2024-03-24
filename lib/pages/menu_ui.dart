import "package:flutter/material.dart";
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/menu.dart';
import 'package:resourcesr/data/User.dart';
import 'package:resourcesr/pages/Home/home_ui.dart';
import 'package:resourcesr/pages/auth/profile_ui.dart';

class MenuUi extends StatelessWidget {
  MenuUi({required this.user});
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Menu", back: false),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              leading: TextAvatar(text: user.name ?? "Your Name"),
              title: Text(user.name ?? "Your Name"),
              subtitle: Text(user.role ?? "Your Status"),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUi(
                              user: user,
                            )))
              },
            ),
            Divider(),
            ...menu(context),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => {
                user.logout(),
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeUi()))
              },
            ),
          ],
        ),
      ),
    );
  }
}
