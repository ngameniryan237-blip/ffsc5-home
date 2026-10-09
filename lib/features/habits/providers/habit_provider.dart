import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  HabitCategory? _selectedCategory;

  HabitProvider() {
    _initDefaultHabits();
  }

  List<Habit> get habits => List.unmodifiable(_habits);
  HabitCategory? get selectedCategory => _selectedCategory;

  List<Habit> get filteredHabits {
    if (_selectedCategory == null) return habits;
    return _habits.where((h) => h.category == _selectedCategory).toList();
  }

  int get totalCompletedToday {
    return _habits.where((h) => h.isCompletedToday).length;
  }

  double get completionRateToday {
    if (_habits.isEmpty) return 0.0;
    return (totalCompletedToday / _habits.length) * 100;
  }

  int get longestStreak {
    if (_habits.isEmpty) return 0;
    return _habits.map((h) => h.currentStreak).reduce((a, b) => a > b ? a : b);
  }

  void setCategoryFilter(HabitCategory? category) {
    if (_selectedCategory == category) {
      _selectedCategory = null;
    } else {
      _selectedCategory = category;
    }
    notifyListeners();
  }

  void addHabit({
    required String title,
    required String description,
    required HabitCategory category,
    int targetDays = 7,
    IconData icon = Icons.check_circle_outline,
    Color color = const Color(0xFF10B981),
  }) {
    final newHabit = Habit(
      id: 'habit_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: description,
      category: category,
      targetDaysPerWeek: targetDays,
      icon: icon,
      color: color,
    );
    _habits.add(newHabit);
    notifyListeners();
  }

  void toggleHabitToday(String habitId, {DateTime? date}) {
    final index = _habits.indexWhere((h) => h.id == habitId);
    if (index == -1) return;

    final targetDate = date ?? DateTime.now();
    final dateKey = '${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}';

    final habit = _habits[index];
    final updatedDates = Set<String>.from(habit.completedDates);

    if (updatedDates.contains(dateKey)) {
      updatedDates.remove(dateKey);
    } else {
      updatedDates.add(dateKey);
    }

    final newStreak = Habit.calculateStreak(updatedDates, targetDate);

    _habits[index] = habit.copyWith(
      completedDates: updatedDates,
      currentStreak: newStreak,
    );

    notifyListeners();
  }

  void deleteHabit(String habitId) {
    _habits.removeWhere((h) => h.id == habitId);
    notifyListeners();
  }

  void resetToDefaults() {
    _initDefaultHabits();
    _selectedCategory = null;
    notifyListeners();
  }

  void _initDefaultHabits() {
    final now = DateTime.now();
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final yesterday = now.subtract(const Duration(days: 1));
    final yKey = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
    final d2 = now.subtract(const Duration(days: 2));
    final d2Key = '${d2.year}-${d2.month.toString().padLeft(2, '0')}-${d2.day.toString().padLeft(2, '0')}';

    _habits = [
      Habit(
        id: 'habit_1',
        title: 'Morning Meditation',
        description: '10 minutes of deep mindfulness breathing',
        category: HabitCategory.mind,
        targetDaysPerWeek: 7,
        completedDates: {today, yKey, d2Key},
        currentStreak: 3,
        icon: Icons.self_improvement,
        color: const Color(0xFF8B5CF6),
      ),
      Habit(
        id: 'habit_2',
        title: 'Hydrate 2.5L Water',
        description: 'Drink 8 glasses of pure water throughout the day',
        category: HabitCategory.nutrition,
        targetDaysPerWeek: 7,
        completedDates: {today, yKey},
        currentStreak: 2,
        icon: Icons.water_drop,
        color: const Color(0xFF06B6D4),
      ),
      Habit(
        id: 'habit_3',
        title: 'HIIT & Mobility Session',
        description: '30 minutes high-intensity core & cardio training',
        category: HabitCategory.body,
        targetDaysPerWeek: 5,
        completedDates: {yKey, d2Key},
        currentStreak: 2,
        icon: Icons.fitness_center,
        color: const Color(0xFFF43F5E),
      ),
      Habit(
        id: 'habit_4',
        title: 'Deep Focus Coding / Reading',
        description: '45 minutes uninterrupted deep work block',
        category: HabitCategory.productivity,
        targetDaysPerWeek: 6,
        completedDates: {today, yKey, d2Key},
        currentStreak: 3,
        icon: Icons.lightbulb,
        color: const Color(0xFFF59E0B),
      ),
    ];
  }
}
