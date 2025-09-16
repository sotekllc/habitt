import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

enum ThemeMode { LIGHT, DARK }

final String STORAGE_KEY = 'theme_mode';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.LIGHT;
  final LocalStorage storage;

  ThemeMode get mode => _mode;

  // void set mode(ThemeMode mode) {
  //   this._mode = mode;
  // }

  ThemeProvider({required this.storage}) {
    var storedThemeMode = storage.getItem(STORAGE_KEY);

    this._mode = ThemeMode.values.firstWhere(
      (e) => e.toString() == storedThemeMode,
      orElse: () => ThemeMode.LIGHT, // fallback if not found
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
    this._mode = ThemeMode.DARK;
    _storeThemeMode();
    notifyListeners();
  }

  void switchToLightMode() {
    this._mode = ThemeMode.LIGHT;
    _storeThemeMode();
    notifyListeners();
  }
}
