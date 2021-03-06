import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  CustomForm({this.children, this.imagePath, this.loading, this.fromKey});
  List<Widget> children;
  String imagePath;
  bool loading;
  Key fromKey;

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) imagePath = "assets/images/logo.png";
    return Form(
      key: fromKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          loading ? LinearProgressIndicator() : SizedBox(height: 2),
          SizedBox(height: 30),
          Image.asset(
            imagePath,
            height: 230,
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
