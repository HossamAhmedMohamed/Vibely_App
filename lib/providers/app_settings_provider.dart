import 'package:flutter/material.dart';

class AppSettingsProvider with ChangeNotifier {
  String _currentLanguage = "English";
  String get currentLanguage => _currentLanguage;

  bool _isDark = false;
  bool get isDark => _isDark;

  // setIsDark(bool value) {
  //   _isDark = value;
  //   notifyListeners();
  // }

  updateDarkMode(bool value, BuildContext context) {
    _isDark = value;
    // if (_isDark) {
    //   AdaptiveTheme.of(context).setDark();
    // } else {
    //   AdaptiveTheme.of(context).setLight();
    // }
    notifyListeners();
  }

  updateLanguage(String lang) {
    _currentLanguage = lang;
    notifyListeners();
  }
}
