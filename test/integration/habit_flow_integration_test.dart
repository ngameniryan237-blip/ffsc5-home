import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/app.dart';
import 'package:zenith_wellness/features/habits/presentation/widgets/habit_card.dart';

void main() {
  group('E2E Habit & Language Integration Test', () {
    testWidgets('Complete user journey: Toggle habit, create custom habit, and switch language to French', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ZenithApp());
      await tester.pumpAndSettle();

      // 1. Verify on Dashboard
      expect(find.text("Today's Journey"), findsOneWidget);

      // 2. Toggle the first habit on the dashboard
      final firstHabit = find.byType(HabitCard).first;
      expect(firstHabit, findsOneWidget);
      await tester.tap(firstHabit);
      await tester.pumpAndSettle();

      // 3. Navigate to Habits Screen via Bottom Navigation
      await tester.tap(find.byIcon(Icons.check_circle_outline));
      await tester.pumpAndSettle();
      expect(find.text('Habit Tracker'), findsOneWidget);

      // 4. Tap the Add Habit Floating Action Button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // 5. Enter new habit information in the modal sheet
      await tester.enterText(find.byType(TextFormField).first, 'Drink Green Tea');
      await tester.pumpAndSettle();

      // Tap 'Add Habit' submit button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add Habit'));
      await tester.pumpAndSettle();

      // 6. Verify newly created habit appears in list
      expect(find.text('Drink Green Tea'), findsOneWidget);

      // 7. Navigate to Settings Screen
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Settings & Preferences'), findsOneWidget);

      // 8. Switch language to French
      await tester.tap(find.text('Français'));
      await tester.pumpAndSettle();

      // 9. Verify UI text switched to French
      expect(find.text('Paramètres & Préférences'), findsOneWidget);
    });
  });
}
