import "package:flutter/material.dart";
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class WebResourceAppDrawer extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _WebResourceAppDrawerState createState() => _WebResourceAppDrawerState();
}

class _WebResourceAppDrawerState extends State<WebResourceAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(create: (_) => User(), child: AppDrawer()),
    );
  }
}

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawer createState() => _AppDrawer();
}

class _AppDrawer extends State<AppDrawer> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Home"),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeUi()))
        },
      ),
    );
    if (user.uid != null) {
      children.add(ListTile(
        leading: Icon(Icons.people),
        title: Text("Profile"),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginUi()))
        },
      ));
      children.add(ListTile(
        leading: Icon(Icons.timer_outlined),
        title: Text("Timetable"),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginUi()))
        },
      ));
      children.add(ListTile(
        leading: Icon(Icons.logout),
        title: Text("Logout"),
        onTap: () => {user.logout()},
      ));
    } else {
      children.add(ListTile(
        leading: Icon(Icons.people),
        title: Text("Account"),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginUi()))
        },
      ));
    }
    children.add(ListTile(
      leading: Icon(Icons.settings),
      title: Text("Settings"),
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginUi()))
      },
    ));
    /* return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          DrawerHeader(
            child: Text("Menu"),
          ),
          ...children,
        ],
      ),
    );*/
    return Container(
      child: Consumer<User>(
        builder: (context, user, child) => Drawer(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              DrawerHeader(
                child: Text("User ${user.loggedIn.toString()}"),
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
