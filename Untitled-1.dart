import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/KlassEvents.dart';

class TimetableUi extends StatefulWidget {
  TimetableUi({@required this.code});
  String code;
  @override
  _TimetableUiState createState() => _TimetableUiState();
}

class _TimetableUiState extends State<TimetableUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, "Timetable", back: false),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: KlassEvents(klassId: widget.code).getByKlassId(),
      builder: (context, snapshot) {
        if (widget.code == null)
          return EmptyState(
            icon: Icons.library_books,
            text: "Select your course.",
            tSize: 1.5,
            iSize: 70.5,
          );
        if (!snapshot.hasData) return Loader();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    var date = DateTime.now();
    var data = snapshot.toList();
    List children = [];
    for (var items in data) {
      children.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 20.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 60.0,
                child: Text(items.data['start']),
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Monday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Monday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Tuesday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Tueday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Wednesday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Wedesday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Thursday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Thursday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Friday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Friday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
              Container(
                width: 90.0,
                height: 90,
                child: Text(items.data['day'] == 'Saturday'
                    ? items.data['course_title']
                    : ""),
                color: items.data['day'] == 'Saturday'
                    ? Colors.lightBlue
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 20.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 60.0,
                child: Text(""),
              ),
              Container(
                width: 90.0,
                child: Text("Mon"),
              ),
              Container(
                width: 90.0,
                child: Text("Tue"),
              ),
              Container(
                width: 90.0,
                child: Text("Wed"),
              ),
              Container(
                width: 90.0,
                child: Text("Thu"),
              ),
              Container(
                width: 90.0,
                child: Text("Fri"),
              ),
              Container(
                width: 90.0,
                child: Text("Sat"),
              ),
            ],
          ),
        ),
        ...children,
      ],
    );
  }
}
