import 'package:flutter/material.dart';
import 'package:riphahwebresources/utils/functions.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextAvatar extends StatelessWidget {
  TextAvatar({this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: text != null ? Color(StringToHex.toColor(text)) : null,
        child: text != null ? Text(getTitle(text)) : null,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class FileIconAvatar extends StatelessWidget {
  FileIconAvatar({this.fileType});
  String fileType;

  getIconPath() {
    Map<String, String> icons = {
      "doc": "word.svg",
      "pdf": "pdf.svg",
      "word": "word.svg",
      "zip": "zip.svg",
      "ppt": "powerpoint.svg",
      "pptx": "powerpoint.svg",
      "powerpoint": "powerpoint.svg"
    };
    if (fileType != null) {
      return "assets/images/files/" + (icons[fileType] ?? "file.svg");
    }
    return "assets/images/files/file.svg";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 20,
        child: SvgPicture.asset(getIconPath()),
      ),
    );
  }
}

class ImageAvatar extends StatelessWidget {
  ImageAvatar(this.url);
  String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(url),
        child: null,
      ),
    );
  }
}
