import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../widgets/activity_ring_painter.dart';
import '../../../habits/providers/habit_provider.dart';
import '../../../habits/presentation/widgets/habit_card.dart';
import '../../../workouts/providers/workout_provider.dart';
import '../../../workouts/presentation/screens/workout_session_screen.dart';
import '../../../../core/widgets/section_header.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
  final void Function(int)? onNavigateTab;

  const DashboardScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dashboard = context.watch<DashboardProvider>();
    final habits = context.watch<HabitProvider>();
    final workouts = context.watch<WorkoutProvider>();

    final cardColor = theme.cardTheme.color ?? theme.cardColor;
    final completionPercent = habits.completionRateToday.toInt();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Text(
              l10n.dashboardTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak & Progress Hero Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                l10n.dailyStreak(habits.longestStreak),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.dashboardSubtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.completionRate(completionPercent),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Progress Circle in Banner
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: CircularProgressIndicator(
                          value: habits.completionRateToday / 100,
                          strokeWidth: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      Text(
                        '$completionPercent%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Concentric Activity Rings Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  RepaintBoundary(
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: CustomPaint(
                        painter: ActivityRingPainter(
                          moveProgress: dashboard.caloriesProgress,
                          exerciseProgress: dashboard.activeMinutesProgress,
                          waterProgress: dashboard.waterProgress,
                          trackColor: theme.brightness == Brightness.dark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _RingLegend(
                          label: l10n.caloriesBurned(dashboard.caloriesBurned),
                          target: '${dashboard.caloriesGoal} kcal',
                          color: const Color(0xFFF43F5E),
                          icon: Icons.local_fire_department,
                        ),
                        const SizedBox(height: 8),
                        _RingLegend(
                          label: l10n.activeMinutes(dashboard.activeMinutes),
                          target: '${dashboard.activeMinutesGoal}m',
                          color: const Color(0xFF10B981),
                          icon: Icons.timer_outlined,
                        ),
                        const SizedBox(height: 8),
                        _RingLegend(
                          label: l10n.waterLogged(dashboard.waterLoggedMl),
                          target: '${dashboard.waterGoalMl}ml',
                          color: const Color(0xFF06B6D4),
                          icon: Icons.water_drop_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Quick Actions Strip
            SectionHeader(title: l10n.quickActions),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _QuickActionButton(
                    icon: Icons.water_drop,
                    label: '+250ml Water',
                    color: const Color(0xFF06B6D4),
                    onTap: () => dashboard.logWater(250),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.local_fire_department,
                    label: '+150 kcal',
                    color: const Color(0xFFF43F5E),
                    onTap: () => dashboard.logCalories(150),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.timer,
                    label: '+15 min Exercise',
                    color: const Color(0xFF10B981),
                    onTap: () => dashboard.addActiveMinutes(15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Today's Habits Section
            SectionHeader(
              title: l10n.todayHabits,
              actionLabel: l10n.viewAll,
              onAction: () => onNavigateTab?.call(1),
            ),
            ...habits.habits.take(3).map(
                  (habit) => HabitCard(
                    habit: habit,
                    onToggle: () => habits.toggleHabitToday(habit.id),
                  ),
                ),
            const SizedBox(height: 16),
            // Featured Workout Card
            if (workouts.workouts.isNotEmpty) ...[
              SectionHeader(
                title: 'Featured Workout',
                actionLabel: l10n.viewAll,
                onAction: () => onNavigateTab?.call(2),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: workouts.workouts.first.accentColor.withValues(alpha: 0.15),
                    foregroundColor: workouts.workouts.first.accentColor,
                    child: Icon(workouts.workouts.first.icon),
                  ),
                  title: Text(
                    workouts.workouts.first.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${workouts.workouts.first.durationMinutes} mins • ${workouts.workouts.first.estimatedCalories} kcal',
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: workouts.workouts.first.accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      workouts.startSession(workouts.workouts.first);
                      Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (ctx) =>
                              WorkoutSessionScreen(workout: workouts.workouts.first),
                        ),
                      );
                    },
                    child: const Text('Start'),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _RingLegend extends StatelessWidget {
  final String label;
  final String target;
  final Color color;
  final IconData icon;

  const _RingLegend({
    required this.label,
    required this.target,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          target,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: ActionChip(
        avatar: Icon(icon, color: color, size: 16),
        label: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
        backgroundColor: color.withValues(alpha: 0.1),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onTap,
      ),
    );
  }
}
