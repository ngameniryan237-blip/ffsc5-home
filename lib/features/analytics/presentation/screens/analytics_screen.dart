import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/analytics_provider.dart';
import '../widgets/weekly_chart_painter.dart';
import '../../../workouts/providers/workout_provider.dart';
import '../../../habits/providers/habit_provider.dart';
import '../../../../core/widgets/metric_card.dart';
import '../../../../core/widgets/section_header.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final analytics = context.watch<AnalyticsProvider>();
    final workoutProvider = context.watch<WorkoutProvider>();
    final habitProvider = context.watch<HabitProvider>();

    final cardColor = theme.cardTheme.color ?? theme.cardColor;
    final avgRate = analytics.averageWeeklyCompletionRate.toInt();
    final healthScore = AnalyticsProvider.calculateHealthScore(
      completedHabits: habitProvider.totalCompletedToday,
      completedWorkouts: workoutProvider.completedWorkoutsCount,
      waterAmountMl: 2000,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.analyticsTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPI Summary Grid
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    title: 'Health Score',
                    value: '$healthScore pts',
                    subtitle: 'Top 5%',
                    icon: Icons.auto_awesome,
                    accentColor: const Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    title: 'Weekly Avg',
                    value: '$avgRate%',
                    subtitle: '+4% vs last wk',
                    icon: Icons.trending_up,
                    accentColor: const Color(0xFF6366F1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    title: 'Workouts Done',
                    value: '${workoutProvider.completedWorkoutsCount}',
                    subtitle: '${workoutProvider.totalMinutesExercised} mins',
                    icon: Icons.fitness_center,
                    accentColor: const Color(0xFFF43F5E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCard(
                    title: 'Best Streak',
                    value: '${habitProvider.longestStreak} days',
                    subtitle: 'Active record',
                    icon: Icons.local_fire_department,
                    accentColor: const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Weekly Consistency Chart
            SectionHeader(title: l10n.weeklyOverview),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.weeklyAverage(avgRate),
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RepaintBoundary(
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: CustomPaint(
                        painter: WeeklyChartPainter(
                          metrics: analytics.weeklyData,
                          primaryColor: theme.colorScheme.primary,
                          todayColor: const Color(0xFFF59E0B),
                          backgroundColor: theme.brightness == Brightness.dark
                              ? const Color(0xFF334155)
                              : const Color(0xFFF1F5F9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Category Focus Distribution
            SectionHeader(title: l10n.categoryDistribution),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Column(
                children: analytics.categoryDistributions.map<Widget>((CategoryDistribution dist) {
                  final percent = (dist.percentage * 100).toInt();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dist.categoryName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$percent%',
                              style: TextStyle(
                                color: dist.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: dist.percentage,
                            minHeight: 8,
                            backgroundColor: theme.brightness == Brightness.dark
                                ? const Color(0xFF334155)
                                : const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(dist.color),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
