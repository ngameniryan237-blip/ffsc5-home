import 'package:flutter/material.dart';
import '../../models/workout.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onTap,
  });

  String _getIntensityLabel(WorkoutIntensity intensity) {
    switch (intensity) {
      case WorkoutIntensity.easy:
        return 'Beginner';
      case WorkoutIntensity.medium:
        return 'Intermediate';
      case WorkoutIntensity.hard:
        return 'Advanced';
    }
  }

  Color _getIntensityColor(WorkoutIntensity intensity) {
    switch (intensity) {
      case WorkoutIntensity.easy:
        return const Color(0xFF10B981);
      case WorkoutIntensity.medium:
        return const Color(0xFFF59E0B);
      case WorkoutIntensity.hard:
        return const Color(0xFFF43F5E);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.cardColor;

    return Semantics(
      label: '${workout.title}, ${workout.durationMinutes} minutes, ${workout.estimatedCalories} calories, ${_getIntensityLabel(workout.intensity)}',
      button: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? const Color(0xFF334155)
                : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Workout Type Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: workout.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(workout.icon, color: workout.accentColor, size: 28),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getIntensityColor(workout.intensity).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getIntensityLabel(workout.intensity),
                              style: TextStyle(
                                color: _getIntensityColor(workout.intensity),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${workout.durationMinutes} min',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        workout.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '🔥 ${workout.estimatedCalories} kcal • ${workout.exercises.length} exercises',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.play_circle_fill_rounded,
                  color: workout.accentColor,
                  size: 34,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
