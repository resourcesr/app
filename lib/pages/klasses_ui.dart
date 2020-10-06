import "package:flutter/material.dart";
import 'package:riphahwebresources/components/course_item_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/klasses.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/pages/courses_ui.dart';

class KlassesUi extends StatefulWidget {
  KlassesUi({this.dep});
  final String dep;
  @override
  _KlassesUiState createState() => _KlassesUiState();
}

class _KlassesUiState extends State<KlassesUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Classes"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Klasss(department: widget.dep).getByDepartment(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loader();
        if (snapshot.data.documents.isEmpty)
          return EmptyState(
            icon: Icons.class_,
            text: "Sorry, no class found",
            tSize: 1.5,
            iSize: 40.5,
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
          child: CourseItemView(
        lIcon: Icons.class_,
        title: data.data['name'],
        sTitle: data.data['cr'],
        tIcon: Icons.arrow_forward,
        route: () => CoursesUi(
          code: data.documentID,
        ),
      )),
    );
  }
}
