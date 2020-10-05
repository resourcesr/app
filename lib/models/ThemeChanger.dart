import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = _isDark ? false : true;
    notifyListeners();
  }
}
