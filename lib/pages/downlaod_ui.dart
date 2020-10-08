import 'dart:io';

import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/components/empty_state.dart';
import 'package:riphahwebresources/components/loader.dart';
import 'package:riphahwebresources/data/Downloader.dart';
import 'package:riphahwebresources/functions.dart';

class DownloadUi extends StatefulWidget {
  List<Widget> children = [];
  @override
  _DownloadUiState createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  Downloader downloader = Downloader();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var tasks;
  bool loading = true;

  void onDeleted(context) {
    widget.children = [];
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
    Navigator.pop(context);
  }

  _showBottomSheet(taskId) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.file_present),
                  title: Text("Open"),
                  onTap: () =>
                      {downloader.open(taskId), Navigator.pop(context)},
                ),
                ListTile(
                  leading: Icon(Icons.download_rounded),
                  title: Text("Delete"),
                  onTap: () => {
                    downloader.delete(taskId),
                    Navigator.pop(context),
                    onDeleted(context),
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
      //print(task.timeCreated);
      var name = task.filename;
      var icon = name.split(".").last;
      bool hasFile = await File('${task.savedDir}/${task.filename}').exists();
      if (hasFile) {
        widget.children.add(
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: FileIconAvatar(fileType: icon),
              ),
              title: Text(task.filename),
              subtitle: Text(time_ago(task.timeCreated)),
              onTap: () => {_showBottomSheet(task.taskId)},
            ),
          ),
        );
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
    return Container(
      child: ListView(
        children: <Widget>[...widget.children],
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
