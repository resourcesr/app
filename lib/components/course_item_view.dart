import 'package:flutter/material.dart';
import 'package:resourcesr/components/avatars.dart';

class CourseItemView extends StatelessWidget {
  CourseItemView({required this.lIcon, required this.title, required this.sTitle, required this.tIcon, required this.route});

  final IconData lIcon;
  final String title;
  final String sTitle;
  final IconData tIcon;
  final Function route;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          leading: TextAvatar(
            text: this.title,
          ),
          title: Text(
            this.title,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            this.sTitle,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          //trailing: Icon(this.tIcon, size: 30),
          onTap: () {
            // Navigate to the second screen using a named route.
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => this.route()));
          }),
    );
  }
}
