import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/habits/models/habit.dart';
import 'package:zenith_wellness/features/habits/providers/habit_provider.dart';

void main() {
  group('HabitProvider Unit Tests', () {
    late HabitProvider provider;

    setUp(() {
      provider = HabitProvider();
    });

    test('Initial state contains default seeded habits', () {
      expect(provider.habits.isNotEmpty, true);
      expect(provider.habits.length, 4);
    });

    test('Adding a new habit adds it to the list and triggers notification', () {
      final initialCount = provider.habits.length;
      provider.addHabit(
        title: 'Morning Run',
        description: '5km jog around the park',
        category: HabitCategory.body,
        targetDays: 5,
      );

      expect(provider.habits.length, initialCount + 1);
      final added = provider.habits.last;
      expect(added.title, 'Morning Run');
      expect(added.category, HabitCategory.body);
      expect(added.targetDaysPerWeek, 5);
    });

    test('Toggling a habit today updates completedDates and recalculates streak', () {
      final habit = provider.habits.first;
      final wasCompleted = habit.isCompletedToday;

      provider.toggleHabitToday(habit.id);
      final updatedHabit = provider.habits.firstWhere((h) => h.id == habit.id);

      expect(updatedHabit.isCompletedToday, !wasCompleted);
    });

    test('Deleting a habit removes it from the habits list', () {
      final habitId = provider.habits.first.id;
      final initialCount = provider.habits.length;

      provider.deleteHabit(habitId);

      expect(provider.habits.length, initialCount - 1);
      expect(provider.habits.any((h) => h.id == habitId), false);
    });

    test('Filtering habits by category returns only habits in that category', () {
      provider.setCategoryFilter(HabitCategory.mind);
      expect(provider.selectedCategory, HabitCategory.mind);
      for (final h in provider.filteredHabits) {
        expect(h.category, HabitCategory.mind);
      }

      // Clear filter
      provider.setCategoryFilter(HabitCategory.mind);
      expect(provider.selectedCategory, isNull);
      expect(provider.filteredHabits.length, provider.habits.length);
    });

    test('Calculating completion rate returns correct percentage', () {
      final rate = provider.completionRateToday;
      expect(rate, isNotNull);
      expect(rate >= 0.0 && rate <= 100.0, true);
    });

    test('Streak calculation handles continuous consecutive days', () {
      final today = DateTime.now();
      final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      final y = today.subtract(const Duration(days: 1));
      final yKey = '${y.year}-${y.month.toString().padLeft(2, '0')}-${y.day.toString().padLeft(2, '0')}';
      final d2 = today.subtract(const Duration(days: 2));
      final d2Key = '${d2.year}-${d2.month.toString().padLeft(2, '0')}-${d2.day.toString().padLeft(2, '0')}';

      final dates = {todayKey, yKey, d2Key};
      final streak = Habit.calculateStreak(dates, today);
      expect(streak, 3);
    });
  });
}
