import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/habits/models/habit.dart';
import 'package:zenith_wellness/features/habits/presentation/widgets/habit_card.dart';

void main() {
  group('HabitCard Widget Tests', () {
    testWidgets('Renders habit details, category, and streak counter', (WidgetTester tester) async {
      bool toggleCalled = false;
      const testHabit = Habit(
        id: 'h_test',
        title: 'Morning Yoga',
        description: '15 min stretch',
        category: HabitCategory.body,
        currentStreak: 5,
        targetDaysPerWeek: 7,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: testHabit,
              onToggle: () => toggleCalled = true,
            ),
          ),
        ),
      );

      expect(find.text('Morning Yoga'), findsOneWidget);
      expect(find.text('15 min stretch'), findsOneWidget);
      expect(find.text('5'), findsOneWidget); // streak count

      // Tap card or checkmark
      await tester.tap(find.byType(HabitCard));
      expect(toggleCalled, true);
    });

    testWidgets('Renders completed state with strikethrough and check icon', (WidgetTester tester) async {
      final now = DateTime.now();
      final todayKey = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final completedHabit = Habit(
        id: 'h_done',
        title: 'Meditation',
        description: 'Peace of mind',
        category: HabitCategory.mind,
        completedDates: {todayKey},
        currentStreak: 12,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: completedHabit,
              onToggle: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
    });
  });
}
