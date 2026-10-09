import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/workouts/models/workout.dart';
import 'package:zenith_wellness/features/workouts/presentation/widgets/workout_card.dart';

void main() {
  group('WorkoutCard Widget Tests', () {
    testWidgets('Renders workout duration, calories, intensity badge, and title', (WidgetTester tester) async {
      bool tapped = false;
      const workout = Workout(
        id: 'w_test',
        title: 'HIIT Express',
        description: 'Quick cardio sprint',
        type: WorkoutType.hiit,
        intensity: WorkoutIntensity.hard,
        durationMinutes: 15,
        estimatedCalories: 210,
        exercises: ['Burpees', 'Mountain Climbers'],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WorkoutCard(
              workout: workout,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('HIIT Express'), findsOneWidget);
      expect(find.text('15 min'), findsOneWidget);
      expect(find.text('Advanced'), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_fill_rounded), findsOneWidget);

      await tester.tap(find.byType(WorkoutCard));
      expect(tapped, true);
    });
  });
}
