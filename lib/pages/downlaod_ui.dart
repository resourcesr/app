import 'dart:io';

import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/Downloader.dart';
import 'package:riphahwebresources/utils/functions.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';

class DownloadUi extends StatefulWidget {
  List<Map> children = [];
  @override
  _DownloadUiState createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  Downloader downloader = Downloader();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var tasks;
  bool loading = true;

  void onDeleted(context, id) {
    load();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("File has been deleted."),
        action: SnackBarAction(
          label: "Close",
          onPressed: () => {},
        ),
      ),
    );
    setState(() {
      /// remove the item form list.
      //widget.children.removeWhere((element) => element['id'] == id);
      widget.children.clear();
    });
  }

  void _openFile(file) async {
    try {
      await OpenFile.open(file);
    } catch (_) {}
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
            Navigator.pop(context);
            onDeleted(context, taskId);
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

  _showBottomSheet(taskId, file) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text("Open"),
                  onTap: () => {_openFile(file), Navigator.pop(context)},
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Share"),
                  onTap: () => {
                    Share.shareFiles([file])
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_forever),
                  title: Text("Delete"),
                  onTap: () => {
                    _confirmBox(context, taskId),
                  },
                ),
              ],
            ),
          );
        });
  }

  _DownloadUiState() {
    load();
  }
  load() async {
    var tasks = await downloader.getAll();
    for (var task in tasks) {
      var name = task.filename;
      var icon = name.split(".").last;
      bool hasFile = await File('${task.savedDir}/${task.filename}').exists();
      if (hasFile) {
        widget.children.addAll([
          {
            "id": task.taskId,
            "title": task.filename,
            "subtitle": timeAgo(task.timeCreated),
            "icon": icon,
            "dir": task.savedDir,
            "url": task.savedDir + "/" + task.filename
          }
        ]);
      }
    }
    setState(() {
      loading = false;
    });
  }

  Widget _body() {
    if (loading) return Loader();
    if (widget.children.isEmpty)
      return EmptyState(
        icon: Icons.download_done_outlined,
        text: "No downloads",
        tSize: 1.5,
        iSize: 40.5,
      );

    List<Widget> childrens = [];
    for (var items in widget.children) {
      childrens.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: FileIconAvatar(fileType: items['icon']),
            ),
            title: Text(items['title']),
            subtitle: Text(items['subtitle']),
            onTap: () => {_showBottomSheet(items['id'], items['url'])},
          ),
        ),
      );
    }
    return Container(
      child: ListView(
        children: <Widget>[...childrens],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(context, "My Downloads"),
      body: _body(),
    );
  }
}
