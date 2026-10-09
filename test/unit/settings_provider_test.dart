import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/settings/providers/settings_provider.dart';

void main() {
  group('SettingsProvider Unit Tests', () {
    late SettingsProvider provider;

    setUp(() {
      provider = SettingsProvider();
    });

    test('Initial default settings values', () {
      expect(provider.locale.languageCode, 'en');
      expect(provider.themeMode, ThemeMode.system);
      expect(provider.isHighContrast, false);
      expect(provider.reduceAnimations, false);
    });

    test('Setting locale changes language and triggers update', () {
      provider.setLocale(const Locale('fr'));
      expect(provider.locale.languageCode, 'fr');

      provider.toggleLanguage();
      expect(provider.locale.languageCode, 'en');
    });

    test('Setting ThemeMode updates properly', () {
      provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);

      provider.setThemeMode(ThemeMode.light);
      expect(provider.themeMode, ThemeMode.light);
    });

    test('Toggling accessibility options (high contrast & animations)', () {
      provider.setHighContrast(true);
      expect(provider.isHighContrast, true);

      provider.setReduceAnimations(true);
      expect(provider.reduceAnimations, true);
    });

    test('Resetting defaults restores original config', () {
      provider.setLocale(const Locale('fr'));
      provider.setThemeMode(ThemeMode.dark);
      provider.setHighContrast(true);
      provider.setReduceAnimations(true);

      provider.resetDefaults();
      expect(provider.locale.languageCode, 'en');
      expect(provider.themeMode, ThemeMode.system);
      expect(provider.isHighContrast, false);
      expect(provider.reduceAnimations, false);
    });
  });
}
