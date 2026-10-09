import 'package:flutter_test/flutter_test.dart';
import 'package:zenith_wellness/features/analytics/providers/analytics_provider.dart';

void main() {
  group('Analytics Provider & Logic Unit Tests', () {
    late AnalyticsProvider provider;

    setUp(() {
      provider = AnalyticsProvider();
    });

    test('Weekly completion average is computed accurately', () {
      final avg = provider.averageWeeklyCompletionRate;
      expect(avg, greaterThan(50.0));
      expect(avg, lessThanOrEqualTo(100.0));
    });

    test('Health Score calculation combines habits, workouts, and water intake', () {
      final score1 = AnalyticsProvider.calculateHealthScore(
        completedHabits: 3,
        completedWorkouts: 1,
        waterAmountMl: 2000,
      );
      // (3 * 15) + (1 * 30) + (8 * 5) = 45 + 30 + 40 = 115
      expect(score1, 115);

      final score0 = AnalyticsProvider.calculateHealthScore(
        completedHabits: 0,
        completedWorkouts: 0,
        waterAmountMl: 0,
      );
      expect(score0, 0);
    });

    test('Category distribution percentages are valid and non-empty', () {
      expect(provider.categoryDistributions.isNotEmpty, true);
      final total = provider.categoryDistributions.fold(0.0, (sum, d) => sum + d.percentage);
      expect(total, closeTo(1.0, 0.05));
    });
  });
}
