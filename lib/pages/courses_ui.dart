import "package:flutter/material.dart";
import 'package:riphahwebresources/components/course_item_view.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/data/Courses.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/pages/resources_ui.dart';

class CoursesUi extends StatefulWidget {
  CoursesUi({this.code});
  final String code;
  @override
  _CoursesUiState createState() => _CoursesUiState();
}

class _CoursesUiState extends State<CoursesUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Courses"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Courses(code: widget.code).getByClassId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.documents.isEmpty)
          return EmptyState(
            icon: Icons.library_books,
            text: "Sorry, no course found",
            tSize: 2.5,
            iSize: 50.5,
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    final d = snapshot.toList();
    List<Widget> children = [];
    List<int> sems = [];
    for (final item in d) sems.add(item.data['semstor']);
    sems = sems.toSet().toList();
    sems.sort((b, a) => a.compareTo(b));
    for (final i in sems) {
      children.add(ListHeader(title: "Semestor 0" + i.toString()));
      for (final data in d) {
        if (i == data.data['semstor']) {
          children.add(Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              child: CourseItemView(
                lIcon: Icons.class_,
                title: data.data['title'],
                sTitle: data.data['teacher'],
                tIcon: Icons.arrow_forward,
                route: () => ResourcesUi(courseId: data.documentID),
              ),
            ),
          ));
        }
      }
    }

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: children);
  }
}
