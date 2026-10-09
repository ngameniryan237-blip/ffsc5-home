import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme({bool highContrast = false}) {
    final baseColor = highContrast ? Colors.black : AppColors.lightBg;
    final cardColor = highContrast ? Colors.white : AppColors.lightCard;
    final primary = highContrast ? const Color(0xFF047857) : AppColors.primary;
    final textColor = highContrast ? Colors.black : AppColors.lightTextPrimary;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: baseColor,
      primaryColor: primary,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: AppColors.secondary,
        surface: cardColor,
        error: AppColors.accentCoral,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: highContrast ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: highContrast ? Colors.black : AppColors.lightBorder,
            width: highContrast ? 2 : 1,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: baseColor,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primary,
        unselectedItemColor: AppColors.lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
    );
  }

  static ThemeData darkTheme({bool highContrast = false}) {
    final baseColor = highContrast ? AppColors.highContrastBgDark : AppColors.darkBg;
    final cardColor = highContrast ? AppColors.highContrastCardDark : AppColors.darkCard;
    const primary = AppColors.primaryLight;
    const textColor = AppColors.darkTextPrimary;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: baseColor,
      primaryColor: primary,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: AppColors.secondaryLight,
        surface: cardColor,
        error: AppColors.accentCoral,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: textColor,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: highContrast ? AppColors.highContrastBorderDark : AppColors.darkBorder,
            width: highContrast ? 2 : 1,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: baseColor,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5, color: Colors.white),
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5, color: Colors.white),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
      ),
    );
  }
}
