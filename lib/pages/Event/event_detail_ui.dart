import "package:flutter/material.dart";
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/list_header.dart';

class EventDetailUi extends StatelessWidget {
  EventDetailUi({this.title, this.start, this.end, this.room, this.duration});
  var title, start, end, room, duration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () => {Navigator.of(context).pop(true)},
          child: Icon(Icons.close),
        ),
        elevation: 0.0,
        title: Text("Event Detail"),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListHeader(title: title),
        ListTile(
          leading: TextAvatar(text: title),
          title: Text(title),
        ),
        ListTile(leading: Icon(Icons.location_city_rounded), title: Text(room)),
        ListTile(
          leading: Icon(Icons.timer),
          title: Text("Start time"),
          subtitle: Text(start),
        ),
        ListTile(
          leading: Icon(Icons.time_to_leave),
          title: Text("End time"),
          subtitle: Text(end),
        ),
        ListTile(
          leading: Icon(Icons.do_disturb_alt_outlined),
          title: Text("Duration"),
          subtitle: Text(duration),
        ),
      ],
    );
  }
}
