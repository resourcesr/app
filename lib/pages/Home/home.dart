import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/KlassEvents.dart';

class Home extends StatefulWidget {
  Home({this.code});
  String code;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Events", back: false),
      body: _buildBody(context),
    );
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
        if (snapshot.data.documents.isEmpty)
          return EmptyState(
            icon: Icons.hourglass_empty_outlined,
            text: "All set",
            tSize: 1.5,
            iSize: 70.5,
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  DateTime dateTimeFromTime(String time) {
    var t = time.split(":");
    var now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, int.parse(t[0]), int.parse(t[1]));
  }

  _humanize(String time) {
    var t = time.split(":");
    var hr = int.parse(t[0]);
    var mint = int.parse(t[1]);
    return "${hr != 12 ? hr % 12 : hr}:${mint <= 9 ? (mint.toString() + "0") : mint} ${hr >= 12 ? "PM" : "AM"}";
  }

  _duration(String start, String end) {
    var s = start.split(":");
    var e = end.split(":");
    return "${int.parse(e[0]) - int.parse(s[0])}:${int.parse(e[1]) - int.parse(s[1])} hr(s)";
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    var date = DateTime.now();
    var today = DateFormat('EEEE').format(date);
    var time = DateFormat('Hm').format(date);
    final items = snapshot.toList();
    print(time);
    List<Widget> children = [];
    children.add(ListHeader(
      title: 'Today\'s Classes',
    ));
    for (var item in items) {
      var itemDay = item.data['day'].toString().toLowerCase();
      if (today.toLowerCase() == itemDay && item.data['type'] == 'class') {
        bool passed =
            dateTimeFromTime(item.data['end']).isBefore(DateTime.now());
        children.add(
          Card(
            child: Opacity(
              opacity: passed ? 0.5 : 1,
              child: ListTile(
                leading: TextAvatar(
                  text: item.data['course_title'],
                ),
                title: Text(item.data['course_title']),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_humanize(item.data['start']) +
                        " - " +
                        _humanize(item.data['end'])),
                    Text(item.data['room'] ?? ""),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    // TODO Add other events like assignent detaline etc.
    /*children.add(ListHeader(
      title: 'Today\'s Tasks',
    ));*/
    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: children);
  }
}
