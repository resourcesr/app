import 'package:flutter/material.dart';

//TODO
class CustomForm extends StatelessWidget {
  List<Widget> children;
  bool loading;
  Key key;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: ListView(
        children: <Widget>[
          loading ? LinearProgressIndicator() : SizedBox(height: 2),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
