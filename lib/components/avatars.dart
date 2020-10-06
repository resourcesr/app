import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

class TextAvatar extends StatelessWidget {
  TextAvatar({this.text});
  String text;
  String imgUrl;
  getTitle() {
    if (text != null) {
      var slices = text.split(" ");
      if (slices.length > 3) slices = slices.sublist(0, 3);
      return slices
          .map((s) => ((s.length >= 1) ? s[0] : ""))
          .join("")
          .toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: text != null ? Color(StringToHex.toColor(text)) : null,
        backgroundImage: imgUrl != null ? NetworkImage(imgUrl) : null,
        child: text != null ? Text(getTitle()) : null,
        foregroundColor: Colors.white,
      ),
    );
  }
}
