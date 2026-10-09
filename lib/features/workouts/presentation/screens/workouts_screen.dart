import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/workout.dart';
import '../../providers/workout_provider.dart';
import '../widgets/workout_card.dart';
import 'workout_session_screen.dart';
import '../../../../core/widgets/empty_state_view.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  void _openWorkoutSession(BuildContext context, Workout workout) {
    context.read<WorkoutProvider>().startSession(workout);
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (ctx) => WorkoutSessionScreen(workout: workout),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final workoutProvider = context.watch<WorkoutProvider>();
    final workouts = workoutProvider.filteredWorkouts;
    final selectedType = workoutProvider.selectedType;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.workoutsTitle),
      ),
      body: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchWorkouts,
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              onChanged: (val) => workoutProvider.setSearchQuery(val),
            ),
          ),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.filterAll),
                  selected: selectedType == null,
                  onSelected: (_) => workoutProvider.setTypeFilter(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterHiit),
                  selected: selectedType == WorkoutType.hiit,
                  onSelected: (_) => workoutProvider.setTypeFilter(WorkoutType.hiit),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterYoga),
                  selected: selectedType == WorkoutType.yoga,
                  onSelected: (_) => workoutProvider.setTypeFilter(WorkoutType.yoga),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterStrength),
                  selected: selectedType == WorkoutType.strength,
                  onSelected: (_) => workoutProvider.setTypeFilter(WorkoutType.strength),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.filterCardio),
                  selected: selectedType == WorkoutType.cardio,
                  onSelected: (_) => workoutProvider.setTypeFilter(WorkoutType.cardio),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Workouts List
          Expanded(
            child: workouts.isEmpty
                ? const EmptyStateView(
                    icon: Icons.fitness_center,
                    title: 'No workouts found',
                    message: 'Try adjusting your search query or filter criteria.',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return WorkoutCard(
                        workout: workout,
                        onTap: () => _openWorkoutSession(context, workout),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
