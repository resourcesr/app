import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  CustomForm({required this.children, this.imagePath, required this.loading, this.fromKey});

  final List<Widget> children;
  final String? imagePath;
  final bool loading;
  final Key? fromKey;

  @override
  Widget build(BuildContext context) {
    String? imagePath = this.imagePath;
    if (this.imagePath == null) imagePath = "assets/images/logo.png";
    return Form(
      key: fromKey,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          loading ? LinearProgressIndicator() : SizedBox(height: 2),
          SizedBox(height: 30),
          Image.asset(
            imagePath!,
            height: 230,
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}
