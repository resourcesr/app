import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';
import 'package:riphahwebresources/data/Downloader.dart';

class DownloadUi extends StatefulWidget {
  List<Widget> children = [];
  @override
  _DownloadUiState createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  Downloader downloader = Downloader();
  var tasks;
  /*load() {
    var tasks = downloader.getAll();
    tasks.then((val) => {
          for (var task in val)
            {
              widget.children.add(ListTile(
                //leading: Icon(Icons.info),
                title: Text(task.filename),
              )),
              print("test")
            }
        });

    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    //load();
    return Scaffold(
      appBar: customAppBar(context, "My Downloads"),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Test"),
            ),
            ...widget.children
          ],
        ),
      ),
    );
  }
}
