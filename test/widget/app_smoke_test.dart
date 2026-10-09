import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/app.dart';

void main() {
  group('ZenithApp Smoke & Navigation Tests', () {
    testWidgets('App initializes and navigates across all bottom navigation tabs', (WidgetTester tester) async {
      await tester.pumpWidget(const ZenithApp());
      await tester.pumpAndSettle();

      // Verify Dashboard is rendered initially
      expect(find.text("Today's Journey"), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);

      // Navigate to Habits Tab
      await tester.tap(find.byIcon(Icons.check_circle_outline));
      await tester.pumpAndSettle();
      expect(find.text('Habit Tracker'), findsOneWidget);

      // Navigate to Workouts Tab
      await tester.tap(find.byIcon(Icons.fitness_center_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Workout Studio'), findsOneWidget);

      // Navigate to Store Tab
      await tester.tap(find.byIcon(Icons.storefront_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Wellness Marketplace'), findsOneWidget);

      // Navigate to Analytics Tab
      await tester.tap(find.byIcon(Icons.insights_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Performance Analytics'), findsOneWidget);

      // Navigate to Settings Tab
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Settings & Preferences'), findsOneWidget);
    });
  });
}
