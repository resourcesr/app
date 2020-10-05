import "package:flutter/material.dart";
import 'package:riphahwebresources/config.dart';
import 'package:riphahwebresources/data/User.dart';
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/auth/login_ui.dart';
import 'package:riphahwebresources/pages/auth/profile_ui.dart';
import 'package:provider/provider.dart';

class WebResourceAppDrawer extends StatefulWidget {
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
    return Container(
      child: Consumer<User>(
        builder: (context, user, child) => Drawer(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              DrawerHeader(
                child: Text("Mmenu"),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeUi()))
                },
              ),
              if (user.loggedIn)
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text("Profile"),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileUi(
                                  uid: user.uid,
                                )))
                  },
                ),
              if (user.loggedIn)
                ListTile(
                  leading: Icon(Icons.timer_outlined),
                  title: Text("Timetable"),
                  onTap: () => {
                    // Navigator.push(
                    //context, MaterialPageRoute(builder: (context) => LoginUi()))
                  },
                ),
              if (user.loggedIn)
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () => {
                    user.logout(),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUi()))
                  },
                ),
              if (!user.loggedIn)
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text("Account"),
                  onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUi()))
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
