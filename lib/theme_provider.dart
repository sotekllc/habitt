import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

enum UI_THEME { LIGHT, DARK }

final String STORAGE_KEY = 'theme_mode';

class ThemeProvider with ChangeNotifier {
  UI_THEME _mode = UI_THEME.LIGHT;
  final LocalStorage storage;

  UI_THEME get mode => _mode;

  // void set mode(ThemeMode mode) {
  //   this._mode = mode;
  // }

  ThemeProvider({required this.storage}) {
    var storedThemeMode = storage.getItem(STORAGE_KEY);

    this._mode = UI_THEME.values.firstWhere(
      (e) => e.toString() == storedThemeMode,
      orElse: () => UI_THEME.LIGHT, // fallback if not found
    );

    // if (storedThemeMode != null) {
    //   // this._mode = _mode;
    // } else {
    //   this._mode = ThemeMode.LIGHT;
    // }
  }

  void _storeThemeMode() {
    storage.setItem(STORAGE_KEY, this._mode.toString());
  }

  void switchToDarkMode() {
    this._mode = UI_THEME.DARK;
    _storeThemeMode();
    notifyListeners();
  }

  void switchToLightMode() {
    this._mode = UI_THEME.LIGHT;
    _storeThemeMode();
    notifyListeners();
  }
}
