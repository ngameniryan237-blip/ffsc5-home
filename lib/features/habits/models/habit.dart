import 'package:flutter/material.dart';

enum HabitCategory {
  mind,
  body,
  productivity,
  nutrition,
}

class Habit {
  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final int targetDaysPerWeek;
  final Set<String> completedDates; // Format: 'YYYY-MM-DD'
  final int currentStreak;
  final IconData icon;
  final Color color;

  const Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.targetDaysPerWeek = 7,
    this.completedDates = const <String>{},
    this.currentStreak = 0,
    this.icon = Icons.star_rounded,
    this.color = const Color(0xFF10B981),
  });

  bool get isCompletedToday {
    final today = _dateKey(DateTime.now());
    return completedDates.contains(today);
  }

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    HabitCategory? category,
    int? targetDaysPerWeek,
    Set<String>? completedDates,
    int? currentStreak,
    IconData? icon,
    Color? color,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      targetDaysPerWeek: targetDaysPerWeek ?? this.targetDaysPerWeek,
      completedDates: completedDates ?? this.completedDates,
      currentStreak: currentStreak ?? this.currentStreak,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  static String _dateKey(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  /// Calculates the current continuous streak ending today or yesterday
  static int calculateStreak(Set<String> completedDates, DateTime referenceDate) {
    int streak = 0;
    DateTime checkDate = referenceDate;
    final todayKey = _dateKey(checkDate);

    // If not completed today, check if yesterday was completed to preserve streak
    if (!completedDates.contains(todayKey)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
      if (!completedDates.contains(_dateKey(checkDate))) {
        return 0;
      }
    }

    while (completedDates.contains(_dateKey(checkDate))) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }
    return streak;
  }
}
