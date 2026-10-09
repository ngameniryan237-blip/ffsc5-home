import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/workout.dart';
import '../../providers/workout_provider.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class WorkoutSessionScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutSessionScreen({super.key, required this.workout});

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _showCompletionDialog(BuildContext context, Workout workout) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 28),
            const SizedBox(width: 8),
            Expanded(child: Text(l10n.workoutCompleted)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.caloriesEarned(workout.estimatedCalories)),
            const SizedBox(height: 8),
            Text('Session: ${workout.title}'),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final workoutProvider = context.watch<WorkoutProvider>();
    final isRunning = workoutProvider.isSessionRunning;
    final secondsRemaining = workoutProvider.sessionSecondsRemaining;
    final totalSeconds = workout.durationMinutes * 60;
    final progress = totalSeconds > 0 ? (totalSeconds - secondsRemaining) / totalSeconds : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(workout.title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            workoutProvider.resetSession();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Timer Circle with Progress
            Center(
              child: SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        strokeWidth: 10,
                        backgroundColor: theme.colorScheme.surface,
                        valueColor: AlwaysStoppedAnimation<Color>(workout.accentColor),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(secondsRemaining),
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${workout.estimatedCalories} kcal',
                          style: TextStyle(
                            color: workout.accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (isRunning) {
                      workoutProvider.pauseSession();
                    } else {
                      workoutProvider.resumeSession();
                    }
                  },
                  icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(isRunning ? l10n.pauseSession : l10n.resumeSession),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: workout.accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    workoutProvider.finishSession();
                    _showCompletionDialog(context, workout);
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l10n.finishSession),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Exercises List
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Exercise Circuit',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: workout.exercises.length,
              itemBuilder: (context, index) {
                final exercise = workout.exercises[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: workout.accentColor.withValues(alpha: 0.15),
                      foregroundColor: workout.accentColor,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      exercise,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
