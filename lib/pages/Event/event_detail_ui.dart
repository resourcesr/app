import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/list_header.dart';

class EventDetailUi extends StatelessWidget {
  EventDetailUi({this.title, this.start, this.end, this.room});
  var title, start, end, room;
  @override
  @override
  Widget build(BuildContext context) {
    print(title);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () => {Navigator.of(context).pop(true)},
          child: Icon(Icons.close),
        ),
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
      ],
    );
  }
}
