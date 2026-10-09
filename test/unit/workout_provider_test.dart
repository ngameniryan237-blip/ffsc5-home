import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/workouts/models/workout.dart';
import 'package:zenith_wellness/features/workouts/providers/workout_provider.dart';

void main() {
  group('WorkoutProvider Unit Tests', () {
    late WorkoutProvider provider;

    setUp(() {
      provider = WorkoutProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('Initial workouts collection is seeded properly', () {
      expect(provider.workouts.isNotEmpty, true);
      expect(provider.workouts.length, 4);
    });

    test('Filtering workouts by type returns matching category', () {
      provider.setTypeFilter(WorkoutType.hiit);
      expect(provider.selectedType, WorkoutType.hiit);
      expect(provider.filteredWorkouts.every((w) => w.type == WorkoutType.hiit), true);

      provider.setTypeFilter(WorkoutType.hiit);
      expect(provider.selectedType, isNull);
    });

    test('Searching workouts by query filters title or description', () {
      provider.setSearchQuery('yoga');
      expect(provider.filteredWorkouts.length, 1);
      expect(provider.filteredWorkouts.first.type, WorkoutType.yoga);

      provider.setSearchQuery('non_existent_query_xyz');
      expect(provider.filteredWorkouts.isEmpty, true);
    });

    test('Starting and finishing a workout session tracks calories and minutes', () {
      final workout = provider.workouts.first;
      final initialCalories = provider.totalCaloriesBurned;
      final initialMins = provider.totalMinutesExercised;
      final initialCount = provider.completedWorkoutsCount;

      provider.startSession(workout);
      expect(provider.isSessionRunning, true);
      expect(provider.activeWorkout, workout);
      expect(provider.sessionSecondsRemaining, workout.durationMinutes * 60);

      provider.pauseSession();
      expect(provider.isSessionRunning, false);

      provider.resumeSession();
      expect(provider.isSessionRunning, true);

      provider.finishSession();
      expect(provider.isSessionRunning, false);
      expect(provider.completedWorkoutsCount, initialCount + 1);
      expect(provider.totalCaloriesBurned, initialCalories + workout.estimatedCalories);
      expect(provider.totalMinutesExercised, initialMins + workout.durationMinutes);
    });
  });
}
