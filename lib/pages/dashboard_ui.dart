import "package:flutter/material.dart";
//import 'package:resourcesr/components/loader.dart';
import 'package:resourcesr/data/User.dart';
import 'package:resourcesr/pages/Event/home.dart';
import 'package:resourcesr/pages/Courses/courses_ui.dart';
import 'package:resourcesr/pages/menu_ui.dart';
import 'package:resourcesr/pages/Event/timetable_ui.dart';

class DashboardUi extends StatefulWidget {
  DashboardUi(this.user);
  User user;
  @override
  _DashboardUiState createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  int tabIndex = 0;
  List tabs;

  List<BottomNavigationBarItem> initTabs() {
    // Refresh profile data.
    widget.user.refresh();
    List<BottomNavigationBarItem> navItems = [];
    var k_id = widget.user.klass;
    tabs = [
      {
        "name": "Home",
        "icon": Icons.home,
        "page": Home(
          code: k_id ?? null,
        )
      },
      {
        "name": "Courses",
        "icon": Icons.book,
        "page": CoursesUi(
          code: k_id ?? null,
        )
      },
      {
        "name": "Time Table",
        "icon": Icons.calendar_today,
        "page": TimetableUi(code: k_id ?? null)
      },
      {"name": "Menu", "icon": Icons.menu, "page": MenuUi(user: widget.user)}
    ];

    for (var tab in tabs) {
      navItems.add(
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Opacity(
            opacity: 1,
            child: Icon(tab['icon']),
          ),
          activeIcon: Icon(tab['icon']),
          label: tab['name'],
        ),
      );
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
