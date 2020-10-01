import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUi extends StatefulWidget {
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //SharedPreferences prefs =  SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text("Login")),
        body: null //_buildBody(context)
        );
  }
}
