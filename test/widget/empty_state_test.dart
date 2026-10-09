import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/core/widgets/empty_state_view.dart';

void main() {
  group('EmptyStateView Widget Tests', () {
    testWidgets('Renders empty state message and triggers button action', (WidgetTester tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyStateView(
              icon: Icons.checklist_rtl_rounded,
              title: 'No Habits Found',
              message: 'Get started by creating your first habit.',
              buttonLabel: 'Add Habit',
              onButtonPressed: () => buttonPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('No Habits Found'), findsOneWidget);
      expect(find.text('Get started by creating your first habit.'), findsOneWidget);
      expect(find.text('Add Habit'), findsOneWidget);
      expect(find.byIcon(Icons.checklist_rtl_rounded), findsOneWidget);

      await tester.tap(find.text('Add Habit'));
      expect(buttonPressed, true);
    });
  });
}
