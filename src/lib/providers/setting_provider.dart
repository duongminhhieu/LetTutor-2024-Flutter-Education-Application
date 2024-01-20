import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utilities/themes.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale("en", "US");
  Locale get locale => _locale;

  ThemeMode _themeMode = getDeviceThemeMode();
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

}


