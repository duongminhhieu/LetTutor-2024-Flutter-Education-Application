import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

ThemeMode getDeviceThemeMode() {
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  if (brightness == Brightness.light) {
    return ThemeMode.light;
  } else {
    return ThemeMode.dark;
  }
}
