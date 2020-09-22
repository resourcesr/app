import 'package:flutter/material.dart';

class CourseItemView extends StatelessWidget {
  CourseItemView({this.lIcon, this.title, this.sTitle, this.tIcon});

  final IconData lIcon;
  final String title;
  final String sTitle;
  final IconData tIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(this.lIcon, size: 50),
        title: Text(this.title),
        subtitle: Text(this.sTitle),
        trailing: Icon(this.tIcon, size: 30),
      ),
    );
  }
}
