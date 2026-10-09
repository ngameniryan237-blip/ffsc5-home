import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/habit.dart';
import '../../providers/habit_provider.dart';
import '../widgets/habit_card.dart';
import '../widgets/add_habit_dialog.dart';
import '../../../../core/widgets/empty_state_view.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  void _showAddHabitSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return AddHabitDialog(
          onAdd: ({
            required String title,
            required String description,
            required HabitCategory category,
            required int targetDays,
            required IconData icon,
            required Color color,
          }) {
            context.read<HabitProvider>().addHabit(
                  title: title,
                  description: description,
                  category: category,
                  targetDays: targetDays,
                  icon: icon,
                  color: color,
                );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final habitProvider = context.watch<HabitProvider>();
    final habits = habitProvider.filteredHabits;
    final selectedCat = habitProvider.selectedCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.habitsTitle),
        actions: [
          Semantics(
            label: l10n.addHabit,
            button: true,
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: l10n.addHabit,
              onPressed: () => _showAddHabitSheet(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.allHabits),
                  selected: selectedCat == null,
                  onSelected: (_) => habitProvider.setCategoryFilter(null),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.habitCategoryMind),
                  selected: selectedCat == HabitCategory.mind,
                  onSelected: (_) => habitProvider.setCategoryFilter(HabitCategory.mind),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.habitCategoryBody),
                  selected: selectedCat == HabitCategory.body,
                  onSelected: (_) => habitProvider.setCategoryFilter(HabitCategory.body),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.habitCategoryProductivity),
                  selected: selectedCat == HabitCategory.productivity,
                  onSelected: (_) => habitProvider.setCategoryFilter(HabitCategory.productivity),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text(l10n.habitCategoryNutrition),
                  selected: selectedCat == HabitCategory.nutrition,
                  onSelected: (_) => habitProvider.setCategoryFilter(HabitCategory.nutrition),
                ),
              ],
            ),
          ),
          // Habit List
          Expanded(
            child: habits.isEmpty
                ? EmptyStateView(
                    icon: Icons.checklist_rtl_rounded,
                    title: l10n.noHabitsFound,
                    message: 'Keep progressing every day.',
                    buttonLabel: l10n.addHabit,
                    onButtonPressed: () => _showAddHabitSheet(context),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return HabitCard(
                        habit: habit,
                        onToggle: () => habitProvider.toggleHabitToday(habit.id),
                        onDelete: () => habitProvider.deleteHabit(habit.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddHabitSheet(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.addHabit),
      ),
    );
  }
}
