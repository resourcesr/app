import "package:flutter/material.dart";

import '../../drawer.dart';

class HomeUi extends StatefulWidget {
  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(title: Text("EasyTools")),
      drawer: WebResourceAppDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.event_note, size: 50),
                    title: Text('Notes'),
                    subtitle: Text('Let\'s create notes'),
                    onTap: () => navigateToNoteUi(context),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.format_list_bulleted, size: 50),
                    title: Text('Todo'),
                    subtitle: Text("Done your task in time."),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.av_timer, size: 50),
                    title: Text('Clock'),
                    subtitle: Text("See time so you will not get late."),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.assessment, size: 50),
                    title: Text('Calculator'),
                    subtitle: Text("Permorm calculation within seconds."),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.add_circle, size: 50),
                    title: Text('Counter'),
                    subtitle: Text("Counts the important things."),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.settings, size: 50),
                    title: Text('Settings'),
                    subtitle: Text("Manage the app."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }

  Future navigateToNoteUi(context) async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NoteUi()));
  }
}
