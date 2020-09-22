import "package:flutter/material.dart";

class WebResourceAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          DrawerHeader(
            child: Text("Menu"),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
        ],
      ),
    );
  }
}
