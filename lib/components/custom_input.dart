import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  CustomInput(
      {this.controller,
      this.label,
      this.initialValue,
      this.obscureText,
      this.maxLines});
  final TextEditingController controller;
  final String label, initialValue;
  final bool obscureText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20.20),
      child: TextFormField(
        obscureText: obscureText,
        //initialValue: initialValue,
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          labelText: label,
        ),
      ),
    ));
  }
}
