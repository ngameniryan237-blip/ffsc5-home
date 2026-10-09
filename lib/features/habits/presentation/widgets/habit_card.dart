import 'package:flutter/material.dart';
import '../../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = habit.isCompletedToday;
    final cardColor = theme.cardTheme.color ?? theme.cardColor;

    return Semantics(
      label: '${habit.title}, Category: ${habit.category.name}, Streak: ${habit.currentStreak} days, Status: ${isDone ? "Completed" : "Not completed"}',
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDone ? habit.color.withValues(alpha: 0.08) : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDone
                ? habit.color.withValues(alpha: 0.4)
                : (theme.brightness == Brightness.dark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0)),
            width: isDone ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Custom Accessible Checkbox Button
                Semantics(
                  button: true,
                  label: isDone ? 'Mark ${habit.title} incomplete' : 'Mark ${habit.title} completed',
                  toggled: isDone,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDone ? habit.color : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDone ? habit.color : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: isDone
                        ? const Icon(Icons.check, size: 20, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 14),
                // Habit Icon & Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: isDone ? TextDecoration.lineThrough : null,
                          color: isDone
                              ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6)
                              : theme.textTheme.titleMedium?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        habit.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Streak Counter Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '${habit.currentStreak}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onDelete != null) ...[
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: Colors.red.withValues(alpha: 0.7),
                    tooltip: 'Delete Habit',
                    onPressed: onDelete,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
