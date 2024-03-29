import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  CustomInput(
      {required this.validator,
      required this.controller,
      @required this.label,
      this.initialValue,
      this.obscureText = false,
      this.maxLines = 1
    });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? label, initialValue;
  final bool obscureText;
  final int maxLines;

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscurePass = true;

  IconButton? _getSufixIcon(bool obscureText) {
    if (!obscureText) return null;
    return IconButton(
      icon: obscurePass ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
      onPressed: () => {
        setState(() {obscurePass = !obscurePass;})
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.20),
        child: TextFormField(
          obscureText: widget.obscureText ? obscurePass : false,
          //initialValue: initialValue,
          controller: widget.controller,
          validator: widget.validator,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).hintColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).hintColor)),
            labelText: widget.label,
            suffixIcon: _getSufixIcon(widget.obscureText),
          ),
        ),
      ),
    );
  }
}
