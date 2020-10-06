import "package:flutter/material.dart";
import 'package:riphahwebresources/pages/Home/home_ui.dart';
import 'package:riphahwebresources/pages/courses_ui.dart';

class DashboardUi extends StatefulWidget {
  @override
  _DashboardUiState createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  int tabIndex = 0;
  List tabs;

  List<BottomNavigationBarItem> initTabs() {
    List<BottomNavigationBarItem> navItems = [];
    tabs = [
      {"name": "Home", "icon": Icons.home, "page": HomeUi()},
      {"name": "Courses", "icon": Icons.book, "page": CoursesUi()},
      //{"name": "Time Table", "icon": Icons.calendar_today, "page": null},
      {"name": "Menu", "icon": Icons.menu, "page": null}
    ];

    for (var tab in tabs) {
      navItems.add(BottomNavigationBarItem(
        backgroundColor: Theme.of(context).primaryColorDark,
        icon: Opacity(
          opacity: 1,
          child: Icon(tab['icon']),
        ),
        activeIcon: Icon(tab['icon']),
        label: tab['name'],
      ));
    }
    return navItems;
  }

  @override
  Widget build(BuildContext context) {
    var navItems = initTabs();
    return Scaffold(
      key: PageStorageKey('BottomNavigationBar'),
      body: Builder(
        builder: (context) => tabs[tabIndex]["page"],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).accentColor,
        items: navItems,
        onTap: (index) {
          if (tabIndex == index) return;
          setState(() {
            tabIndex = index;
          });
        },
      ),
    );
  }
}
