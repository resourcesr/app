import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/KlassEvents.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:riphahwebresources/pages/event_detail_ui.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:riphahwebresources/utils/functions.dart';

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

  DateTime dateTimeFromTime(String time, day) {
    var t = time.split(":");
    var now = DateTime.now();

    return DateTime(now.year, now.month, day, int.parse(t[0]), int.parse(t[1]));
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    var data = snapshot.toList();
    List<FlutterWeekViewEvent> events = [];
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    var dates = [
      now,
      DateTime(now.year, now.month, now.day + 1),
      DateTime(now.year, now.month, now.day + 2),
      DateTime(now.year, now.month, now.day + 3),
      DateTime(now.year, now.month, now.day + 4),
      DateTime(now.year, now.month, now.day + 5),
      DateTime(now.year, now.month, now.day + 6),
    ];
    for (var _date in dates) {
      for (var items in data) {
        var day = items.data['day'];
        if (DateFormat('EEEE').format(_date) == day) {
          events.add(
            FlutterWeekViewEvent(
              backgroundColor:
                  Color(StringToHex.toColor(items.data['course_title'])),
              title: items.data['course_title'] + " : " + items.data['room'],
              description: "",
              start: dateTimeFromTime(items.data['start'], _date.day),
              end: dateTimeFromTime(items.data['end'], _date.day),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailUi(
                            title: items.data['course_title'],
                            start: humanize(items.data['start']),
                            end: humanize(items.data['end']),
                            room: items.data['room'])))
              },
            ),
          );
        }
      }
    }
    return WeekView(
      initialTime: const HourMinute(hour: 7).atDate(DateTime.now()),
      dates: dates,
      events: events,
    );
  }
}
