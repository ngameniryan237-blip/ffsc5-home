import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;
  bool _highContrast = false;
  bool _reduceAnimations = false;

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get isHighContrast => _highContrast;
  bool get reduceAnimations => _reduceAnimations;

  void setLocale(Locale newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('fr');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void setHighContrast(bool value) {
    if (_highContrast == value) return;
    _highContrast = value;
    notifyListeners();
  }

  void setReduceAnimations(bool value) {
    if (_reduceAnimations == value) return;
    _reduceAnimations = value;
    notifyListeners();
  }

  void resetDefaults() {
    _locale = const Locale('en');
    _themeMode = ThemeMode.system;
    _highContrast = false;
    _reduceAnimations = false;
    notifyListeners();
  }
}
