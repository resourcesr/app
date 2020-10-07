import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/list_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/Downloader.dart';
import 'package:riphahwebresources/data/Resources.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:intl/intl.dart';
import 'package:riphahwebresources/functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ResourcesUi extends StatefulWidget {
  ResourcesUi({this.courseId});
  final String courseId;

  @override
  _ResourcesUiState createState() => _ResourcesUiState();
}

class _ResourcesUiState extends State<ResourcesUi> {
  Downloader downloader = Downloader();
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
      appBar: customAppBar(context, "Resources"),
      //drawer: WebResourceAppDrawer(),
      body: _buildBody(context),
    );
  }

  _openUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  void download(link) async {
    var task = await downloader.start(link);
    print(task);
    print("Downloaded done");
  }

  listTrallingWidget(url) {
    //var task = await downloader.getByUrl(url);
    //if (task.isNotEmpty) return Icon(Icons.offline_pin);

    return null;
  }

  _showBottomSheet(context, url) async {
    var task = await downloader.getByUrl(url);
    List<Widget> children = [];
    if (task.isNotEmpty) {
      var id = task.first.taskId;
      if (task.first.progress == 100) {
        children.add(
          ListTile(
            leading: Icon(Icons.download_rounded),
            title: Text("Delete"),
            onTap: () => {downloader.delete(id), Navigator.pop(context)},
          ),
        );
      } else {
        children.add(
          ListTile(
            leading: Icon(Icons.download_rounded),
            title: Text("Cancel"),
            onTap: () => {downloader.cancel(id), Navigator.pop(context)},
          ),
        );
      }
    } else {
      children.add(
        ListTile(
          leading: Icon(Icons.download_rounded),
          title: Text("Download"),
          onTap: () => {download(url), Navigator.pop(context)},
        ),
      );
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[...children],
            ),
          );
        });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Resources(courseId: widget.courseId).getByCourseId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loader();
        if (snapshot.data.documents.isEmpty)
          return EmptyState(
            icon: Icons.collections_bookmark,
            text: "Sorry, no resources found",
            tSize: 1.5,
            iSize: 40.5,
          );
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  /*_showMaterialDialog(openUrl, downloadUrl) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("downnload"),
              content: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.open_in_browser),
                    title: Text('Open in Browser'),
                    onTap: () => {_openUrl(openUrl)},
                  ),
                  ListTile(
                    leading: Icon(Icons.play_arrow),
                    title: Text('Download'),
                    onTap: () => {download(downloadUrl)},
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }*/

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
                        backgroundColor: Colors.transparent,
                        child: FileIconAvatar(fileType: data.data['icon']),
                      ),
                      title: Text(data.data['name'] ?? ""),
                      subtitle: Text("$formatted"),
                      trailing: listTrallingWidget(data.data['downloadUrl']),
                      onTap: () =>
                          {_showBottomSheet(context, data.data['downloadUrl'])},
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
