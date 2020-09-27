import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget {
  //const CustomAppBar({Key key}) : super(key: key);
  CustomAppBar({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(this.text), centerTitle: true);
  }
}
