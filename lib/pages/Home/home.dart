import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/KlassEvents.dart';
import 'package:riphahwebresources/pages/Event/event_detail_ui.dart';
import 'package:riphahwebresources/utils/functions.dart';

class Home extends StatelessWidget {
  Home({this.code});
  String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Events", back: false),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: KlassEvents(klassId: code).getByKlassId(),
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
      text: "All set",
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
    }
    // ignore: todo
    // TODO Add other events like assignent detaline etc.
    /*children.add(ListHeader(
      title: 'Today\'s Tasks',
    ));*/

    if (children.isEmpty) return _emptyState();

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: header + children);
  }
}
