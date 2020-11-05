import "package:flutter/material.dart";
import 'package:resourcesr/components/menu.dart';
import 'package:resourcesr/pages/Home/home_ui.dart';
import 'package:resourcesr/pages/auth/login_ui.dart';

class WebResourceAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            DrawerHeader(
              child: Text(""),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeUi())),
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Account"),
              onTap: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginUi()))
              },
            ),
            ...menu(context)
          ],
        ),
      ),
    );
  }
}
