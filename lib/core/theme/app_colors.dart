import 'package:flutter/material.dart';

/// Centralized color palette for Zenith Wellness
abstract class AppColors {
  // Brand accents
  static const Color primary = Color(0xFF10B981); // Emerald Teal
  static const Color primaryDark = Color(0xFF059669);
  static const Color primaryLight = Color(0xFF34D399);

  static const Color secondary = Color(0xFF6366F1); // Indigo Blue
  static const Color secondaryDark = Color(0xFF4F46E5);
  static const Color secondaryLight = Color(0xFF818CF8);

  static const Color accentCoral = Color(0xFFF43F5E); // Energy / Calories
  static const Color accentAmber = Color(0xFFF59E0B); // Streaks / Warnings
  static const Color accentCyan = Color(0xFF06B6D4); // Water / Hydration
  static const Color accentPurple = Color(0xFF8B5CF6); // Mindfulness

  // Dark Theme Neutrals
  static const Color darkBg = Color(0xFF0F172A); // Slate 900
  static const Color darkCard = Color(0xFF1E293B); // Slate 800
  static const Color darkCardHover = Color(0xFF334155);
  static const Color darkSurface = Color(0xFF131D31);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  // Light Theme Neutrals
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardHover = Color(0xFFF1F5F9);
  static const Color lightSurface = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // High Contrast Mode Overrides
  static const Color highContrastBgDark = Color(0xFF000000);
  static const Color highContrastCardDark = Color(0xFF121212);
  static const Color highContrastBorderDark = Color(0xFFFFFFFF);
  static const Color highContrastTextDark = Color(0xFFFFFFFF);
}
