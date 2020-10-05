import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';

import '../../drawer.dart';

import 'package:riphahwebresources/components/course_item_view.dart';

import 'package:riphahwebresources/pages/klasses_ui.dart';

class HomeUi extends StatefulWidget {
  @override
  _HomeUiState createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: customAppBar(context, "Home"),
      drawer: WebResourceAppDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CourseItemView(
                    lIcon: Icons.home,
                    title: "Department Of Computing",
                    sTitle: "FC",
                    tIcon: Icons.home,
                    route: () => KlassesUi(dep: "fc"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }

  Future navigateToNoteUi(context, params) async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NoteUi(params)));
  }
}
