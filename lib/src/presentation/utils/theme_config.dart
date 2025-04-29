import 'package:base_flutter/src/core/constants/app_constant.dart';
import 'package:flutter/material.dart';

class ThemeConfig extends ChangeNotifier {
  bool _isDarkTheme = kIsDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  ThemeConfig();

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    notifyListeners();
  }
}
