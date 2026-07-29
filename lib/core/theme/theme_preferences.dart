import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  ThemePreferences._();

  static const String _themeKey = "theme_mode";

  /// Save theme mode
  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_themeKey, "light");
        break;

      case ThemeMode.dark:
        await prefs.setString(_themeKey, "dark");
        break;

      case ThemeMode.system:
        await prefs.setString(_themeKey, "system");
        break;
    }
  }

  /// Load theme mode
  static Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_themeKey);

    switch (value) {
      case "light":
        return ThemeMode.light;

      case "dark":
        return ThemeMode.dark;

      default:
        return ThemeMode.system;
    }
  }
}