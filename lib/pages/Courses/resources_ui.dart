import "package:flutter/material.dart";
import 'package:resourcesr/components/avatars.dart';
import 'package:resourcesr/components/custom_app_bar.dart';
import 'package:resourcesr/components/list_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resourcesr/components/loader.dart';
import 'package:resourcesr/data/Downloader.dart';
import 'package:resourcesr/data/Resources.dart';
import 'package:resourcesr/components/empty_state.dart';
import 'package:intl/intl.dart';
import 'package:resourcesr/utils/functions.dart';
import 'package:resourcesr/utils/url.dart';
import 'package:resourcesr/utils/util.dart';
import 'package:share/share.dart';

class ResourcesUi extends StatefulWidget {
  ResourcesUi({this.courseDetail});
  final courseDetail;

  @override
  _ResourcesUiState createState() => _ResourcesUiState();
}

class _ResourcesUiState extends State<ResourcesUi> {
  Downloader downloader = Downloader();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Resources"),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Material(
              color: Theme.of(context).cardColor,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListTile(
                        leading: TextAvatar(
                          text: widget.courseDetail.data['title'],
                        ),
                        title: Text(widget.courseDetail.data['title']),
                        subtitle: Text(widget.courseDetail.data['code'] +
                            " - " +
                            widget.courseDetail.data['teacher']),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 150.0),
                    child: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(
                          text: "Resources",
                        ),
                        Tab(
                          text: "Assignments",
                        ),
                        Tab(
                          text: "About",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  void download(link, filename) async {
    await downloader.start(link, filename);

    //refresh the state.
    setState(() {});
  }

  listTrallingWidget(url) async {
    final task = await downloader.getByUrl(url);
    if (task.isNotEmpty) return Icons.offline_pin;
    return null;
  }

  _confirmBox(BuildContext context, taskId) {
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure?"),
      actions: <Widget>[
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            downloader.delete(taskId);
            //refresh the state.
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _showBottomSheet(context, url, filename) async {
    var task = await downloader.getByUrl(url);
    List<Widget> children = [];

    children.add(
      ListTile(
        leading: Icon(Icons.file_present),
        title: Text("Open in Browser"),
        onTap: () => {openUrl(url), Navigator.pop(context)},
      ),
    );
    if (task.isNotEmpty) {
      var id = task.first.taskId;
      if (task.first.progress == 100) {
        children.addAll([
          ListTile(
            leading: Icon(Icons.file_present),
            title: Text("Open"),
            onTap: () => {
              openFile(task.first.savedDir + "/" + task.first.filename),
              Navigator.pop(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
            onTap: () => {
              Share.shareFiles(
                  [task.first.savedDir + "/" + task.first.filename]),
              Navigator.pop(context)
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("Delete"),
            onTap: () => {
              _confirmBox(context, task.first.taskId),
            },
          ),
        ]);
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
          onTap: () => {download(url, filename), Navigator.pop(context)},
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

  Widget _emptyState() {
    return EmptyState(
      icon: Icons.collections_bookmark,
      text: "Sorry, no resources found",
      tSize: 1.5,
      iSize: 70.5,
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          Resources(courseId: widget.courseDetail.documentID).getByCourseId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loader();
        //if (snapshot.data.documents.isEmpty) return _emptyState();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    final d = snapshot.toList();

    // this is refer to resources or may be labs too.
    List<Widget> children = [];
    List<Widget> assignments = [];
    List<String> types = [];
    List<String> contents = [];
    for (var item in d) types.add(item.data['type']);
    types = types.toSet().toList();
    for (var item in d) contents.add(item.data['content']);
    contents = contents.toSet().toList();
    for (var content in contents) {
      if (content != "assignment")
        children.add(ListHeader(title: capitalize(content ?? " ")));

      for (var type in types) {
        if (type == 'books') {
          children.add(ListHeader(title: capitalize('Books' ?? " ")));
        }
        for (var data in d) {
          if (content == data.data['content']) {
            if (type == data.data['type'] && data.data['delete'] == null) {
              if (content == "resource" || content == "lab") {
                children.add(buildResources(data));
              } else {
                assignments.add(buildResources(data));
              }
            }
          }
        }
      }
    }
    return TabBarView(children: [
      Container(
        child: children.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.only(top: 20.0), children: children)
            : _emptyState(),
      ),
      Container(
        child: assignments.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.only(top: 20.0),
                children: assignments)
            : _emptyState(),
      ),
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Course title"),
                subtitle: Text(widget.courseDetail.data['title']),
              ),
              ListTile(
                title: Text("Teacher"),
                subtitle: Text(widget.courseDetail.data['teacher']),
              ),
              ListTile(
                title: Text("Credit Code"),
                subtitle: Text(widget.courseDetail.data['code']),
              ),
              ListTile(
                title: Text("Credit Hr(s)"),
                subtitle: Text(widget.courseDetail.data['credit'].toString()),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildResources(data) {
    DateTime date = (data.data['created'] ?? Timestamp.now()).toDate();
    var formatter = new DateFormat('MMM dd, yyyy');
    String formatted = formatter.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: FutureBuilder(
            future: listTrallingWidget(data.data['downloadUrl']),
            builder: (context, snapshot) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: FileIconAvatar(fileType: data.data['icon']),
                ),
                title: Text(data.data['name'] ?? ""),
                subtitle: Text("$formatted"),
                trailing: Icon(snapshot.data),
                onTap: () => {
                  _showBottomSheet(
                      context,
                      data.data['downloadUrl'],
                      getTitle(widget.courseDetail.data['title']) +
                          ":" +
                          data.data['name'] +
                          "." +
                          data.data['icon'])
                },
              );
            }),
      ),
    );
  }
}
