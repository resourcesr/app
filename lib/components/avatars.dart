import 'package:flutter/material.dart';
import 'package:resourcesr/utils/functions.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextAvatar extends StatelessWidget {
  TextAvatar({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: Color(StringToHex.toColor(text)),
        child: Text(getTitle(text)),
        foregroundColor: Colors.white,
      ),
    );
  }
}

class FileIconAvatar extends StatelessWidget {
  FileIconAvatar({required this.fileType});
  final String fileType;

  getIconPath() {
    Map<String, String> icons = {
      "doc": "word.svg",
      "pdf": "pdf.svg",
      "word": "word.svg",
      "zip": "zip.svg",
      "ppt": "powerpoint.svg",
      "pptx": "powerpoint.svg",
      "powerpoint": "powerpoint.svg",
      "PowerPoint": "powerpoint.svg"
    };
    return "assets/images/files/" + (icons[fileType] ?? "file.svg");
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
  final String url;
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
