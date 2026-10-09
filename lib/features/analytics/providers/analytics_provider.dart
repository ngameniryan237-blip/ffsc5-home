import 'package:flutter/material.dart';

class DailyMetric {
  final String dayLabel;
  final double completionRate;
  final bool isToday;

  const DailyMetric({
    required this.dayLabel,
    required this.completionRate,
    this.isToday = false,
  });
}

class CategoryDistribution {
  final String categoryName;
  final double percentage;
  final Color color;

  const CategoryDistribution({
    required this.categoryName,
    required this.percentage,
    required this.color,
  });
}

class AnalyticsProvider extends ChangeNotifier {
  final List<DailyMetric> _weeklyData = const [
    DailyMetric(dayLabel: 'Mon', completionRate: 0.85),
    DailyMetric(dayLabel: 'Tue', completionRate: 1.00),
    DailyMetric(dayLabel: 'Wed', completionRate: 0.75),
    DailyMetric(dayLabel: 'Thu', completionRate: 0.90),
    DailyMetric(dayLabel: 'Fri', completionRate: 0.80),
    DailyMetric(dayLabel: 'Sat', completionRate: 0.60),
    DailyMetric(dayLabel: 'Sun', completionRate: 0.95, isToday: true),
  ];

  final List<CategoryDistribution> _categoryDistributions = const [
    CategoryDistribution(
      categoryName: 'Fitness & Body',
      percentage: 0.35,
      color: Color(0xFFF43F5E),
    ),
    CategoryDistribution(
      categoryName: 'Mindfulness',
      percentage: 0.25,
      color: Color(0xFF8B5CF6),
    ),
    CategoryDistribution(
      categoryName: 'Productivity',
      percentage: 0.25,
      color: Color(0xFFF59E0B),
    ),
    CategoryDistribution(
      categoryName: 'Nutrition',
      percentage: 0.15,
      color: Color(0xFF06B6D4),
    ),
  ];

  List<DailyMetric> get weeklyData => _weeklyData;
  List<CategoryDistribution> get categoryDistributions => _categoryDistributions;

  /// Pure business logic: calculates average weekly score
  double get averageWeeklyCompletionRate {
    if (_weeklyData.isEmpty) return 0.0;
    final total = _weeklyData.fold(0.0, (sum, d) => sum + d.completionRate);
    return (total / _weeklyData.length) * 100;
  }

  /// Calculates points score based on habits + workouts
  static int calculateHealthScore({
    required int completedHabits,
    required int completedWorkouts,
    required int waterAmountMl,
  }) {
    int score = 0;
    score += completedHabits * 15;
    score += completedWorkouts * 30;
    score += (waterAmountMl / 250).clamp(0, 8).toInt() * 5;
    return score;
  }
}
