import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/habits/providers/habit_provider.dart';
import 'features/workouts/providers/workout_provider.dart';
import 'features/store/providers/store_provider.dart';
import 'features/analytics/providers/analytics_provider.dart';
import 'features/settings/providers/settings_provider.dart';
import 'app_shell.dart';
import 'l10n/app_localizations.dart';

class ZenithApp extends StatelessWidget {
  const ZenithApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Zenith Wellness',
            debugShowCheckedModeBanner: false,
            locale: settings.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
            ],
            theme: AppTheme.lightTheme(highContrast: settings.isHighContrast),
            darkTheme: AppTheme.darkTheme(highContrast: settings.isHighContrast),
            themeMode: settings.themeMode,
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
