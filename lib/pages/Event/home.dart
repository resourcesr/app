import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resourcesr/components/empty_state.dart';
import 'package:resourcesr/components/list_header.dart';
import 'package:resourcesr/components/loader.dart';
import 'package:resourcesr/data/KlassEvents.dart';
import 'package:resourcesr/pages/Event/event_detail_ui.dart';
import 'package:resourcesr/utils/functions.dart';

class Home extends StatelessWidget {
  Home({this.code, this.sem});
  String code;
  int sem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Events", back: false),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: KlassEvents(klassId: code, sem: sem).getByKlassId(),
      builder: (context, snapshot) {
        if (code == null)
          return EmptyState(
            icon: Icons.library_books,
            text: "Select your course.",
            tSize: 1.5,
            iSize: 70.5,
          );
        if (!snapshot.hasData) return Loader();
        if (snapshot.data.documents.isEmpty) _emptyState();
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

  Widget _emptyState() {
    return EmptyState(
      icon: Icons.hourglass_empty_outlined,
      text: "No event",
      tSize: 1.5,
      iSize: 70.5,
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    var date = DateTime.now();
    var today = DateFormat('EEEE').format(date);
    final items = snapshot.toList();
    List<Widget> children = [], header = [];
    header.add(ListHeader(
      title: 'Event\'s',
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
                    Text(humanize(item.data['start']) +
                        " - " +
                        humanize(item.data['end'])),
                    Text(item.data['room'] ?? ""),
                  ],
                ),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailUi(
                        title: item.data['course_title'],
                        start: humanize(item.data['start']),
                        end: humanize(item.data['end']),
                        room: item.data['room'],
                        duration: calcluateDuration(
                            item.data['start'], item.data['end']),
                      ),
                    ),
                  )
                },
              ),
            ),
          ),
        );
      }
      if (item.data['type'] != 'class') {
        if ((date.day <= item.data['day'] &&
                date.month == item.data['month']) &&
            date.year == item.data['year']) {
          children.add(
            Card(
              child: ListTile(
                leading: TextAvatar(
                  text: item.data['course_title'],
                ),
                title: Text(item.data['course_title']),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Last date: " +
                        item.data['day'].toString() +
                        "/" +
                        item.data['month'].toString() +
                        " " +
                        item.data['end'].toString()),
                  ],
                ),
              ),
            ),
          );
        }
      }
    }

    if (children.isEmpty) return _emptyState();

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: header + children);
  }
}
