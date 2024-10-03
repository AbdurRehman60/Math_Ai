import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String themePreferenceKey = 'isDarkMode';
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    loadThemeFromPreferences();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    await saveThemeToPreferences();
    notifyListeners();
  }

  Future<void> saveThemeToPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themePreferenceKey, _isDarkMode);
  }

  Future<void> loadThemeFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(themePreferenceKey) ?? false;
    notifyListeners();
  }
}
