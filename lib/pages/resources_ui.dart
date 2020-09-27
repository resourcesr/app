import "package:flutter/material.dart";
//import '../drawer.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/data/Resources.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:intl/intl.dart';
import 'package:riphahwebresources/functions.dart';

class ResourcesUi extends StatefulWidget {
  ResourcesUi({this.courseId});
  final String courseId;
  @override
  _ResourcesUiState createState() => _ResourcesUiState();
}

class _ResourcesUiState extends State<ResourcesUi> {
  @override
  Widget build(BuildContext context) {
    /*return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resources'),
          bottom: TabBar(tabs: [
            Tab(
              text: "Resources",
            ),
            Tab(
              text: "Assignments",
            ),
            Tab(
              text: "Labs",
            ),
            /*Tab(
              text: "Quizes",
            ),*/
            /*Tab(
              text: "About",
            ),*/
          ]),
        ),
        drawer: WebResourceAppDrawer(),
        body: _buildBody(context),
      ),
    );*/
    return Scaffold(
      appBar: AppBar(title: Text('Resources')),
      //drawer: WebResourceAppDrawer(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Resources(courseId: widget.courseId).getByCourseId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.documents.isEmpty)
          return EmptyState(
            icon: Icons.collections_bookmark,
            text: "Sorry, no resources found",
            tSize: 1.5,
            iSize: 50.5,
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    final d = snapshot.toList();
    List<Widget> children = [];
    List<String> types = [];
    List<String> contents = [];
    for (var item in d) types.add(item.data['type']);
    types = types.toSet().toList();
    for (var item in d) contents.add(item.data['content']);
    contents = contents.toSet().toList();
    for (var content in contents) {
      children.add(ListHeader(title: capitalize(content ?? " ")));
      children.add(Divider(
        color: Colors.black,
        height: 5,
        thickness: 3,
        indent: 10,
        endIndent: 10,
      ));
      for (var type in types) {
        if (content != "assignment")
          children.add(ListHeader(title: capitalize(type ?? " ")));
        for (var data in d) {
          if (content == data.data['content']) {
            if (type == data.data['type']) {
              String name = "";
              DateTime date =
                  (data.data['created'] ?? Timestamp.now()).toDate();
              var formatter = new DateFormat('MMM dd, yyyy');
              String formatted = formatter.format(date);
              children.add(
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.book),
                      ),
                      title: Text(data.data['name'] ?? ""),
                      subtitle: Text("$formatted"),
                      trailing: RaisedButton(
                        color: Colors.white,
                        onPressed: () {},
                        child: Icon(Icons.offline_pin),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        }
      }
    }

    return ListView(
        padding: const EdgeInsets.only(top: 20.0), children: children);
  }
}
