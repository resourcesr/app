import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/config.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/dashboard_ui.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';
import 'package:riphahwebresources/pages/auth/profile_ui.dart';
import 'package:provider/provider.dart';
import 'package:riphahwebresources/pages/section/about_ui.dart';

class MenuUi extends StatefulWidget {
  @override
  _MenuUiState createState() => _MenuUiState();
}

class _MenuUiState extends State<MenuUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Menu"),
      body: ChangeNotifierProvider(create: (_) => User(), child: MenuBar()),
    );
  }
}

class MenuBar extends StatefulWidget {
  @override
  _MenuBar createState() => _MenuBar();
}

class _MenuBar extends State<MenuBar> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<User>(
        builder: (context, user, child) => Container(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeUi()))
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.security),
                title: Text("Privacy Policy"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginUi()))
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share app"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginUi()))
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About App"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUi()))
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
