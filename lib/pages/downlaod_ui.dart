import 'dart:io';

import "package:flutter/material.dart";
import 'package:riphahwebresources/components/avatars.dart';
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/data/Downloader.dart';
import 'package:riphahwebresources/functions.dart';

class DownloadUi extends StatefulWidget {
  List<Widget> children = [];
  @override
  _DownloadUiState createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  Downloader downloader = Downloader();
  var tasks;

  open(taskId) async {
    await downloader.open(taskId);
  }

  load() async {
    var tasks = await downloader.getAll();
    for (var task in tasks) {
      //print(task.timeCreated);
      var name = task.filename;
      var icon = name.split(".").last;
      bool hasFile = await File('${task.savedDir}/${task.filename}').exists();
      if (hasFile) {
        widget.children.add(ListTile(
            //leading: Icon(Icons.info),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: FileIconAvatar(fileType: icon),
            ),
            title: Text(task.filename),
            subtitle: Text(time_ago(task.timeCreated)),
            onTap: () => {open(task.taskId)}));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    load();
    return Scaffold(
      appBar: customAppBar(context, "My Downloads"),
      body: Container(
        child: ListView(
          children: <Widget>[...widget.children],
        ),
      ),
    );
  }
}
