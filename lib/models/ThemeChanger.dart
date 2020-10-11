import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeChanger() {
    getState().then((value) => {_isDark = value ?? false});
    notifyListeners();
  }

  Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme');
  }

  void saveState(status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("theme", status);
  }

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = _isDark ? false : true;
    saveState(isDark);
    notifyListeners();
  }
}
