import "package:flutter/material.dart";
import 'package:riphahwebresources/components/custom_app_bar.dart';

import '../../drawer.dart';

import 'package:riphahwebresources/components/course_item_view.dart';

import 'package:riphahwebresources/pages/Courses/klasses_ui.dart';

class HomeUi extends StatelessWidget {
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
}
