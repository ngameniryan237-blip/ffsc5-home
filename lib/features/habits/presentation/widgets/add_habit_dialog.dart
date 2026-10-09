import 'package:flutter/material.dart';
import '../../models/habit.dart';

class AddHabitDialog extends StatefulWidget {
  final void Function({
    required String title,
    required String description,
    required HabitCategory category,
    required int targetDays,
    required IconData icon,
    required Color color,
  }) onAdd;

  const AddHabitDialog({super.key, required this.onAdd});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  HabitCategory _selectedCategory = HabitCategory.body;
  int _targetDays = 7;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Color _getCategoryColor(HabitCategory cat) {
    switch (cat) {
      case HabitCategory.mind:
        return const Color(0xFF8B5CF6);
      case HabitCategory.body:
        return const Color(0xFFF43F5E);
      case HabitCategory.productivity:
        return const Color(0xFFF59E0B);
      case HabitCategory.nutrition:
        return const Color(0xFF06B6D4);
    }
  }

  IconData _getCategoryIcon(HabitCategory cat) {
    switch (cat) {
      case HabitCategory.mind:
        return Icons.self_improvement;
      case HabitCategory.body:
        return Icons.fitness_center;
      case HabitCategory.productivity:
        return Icons.lightbulb;
      case HabitCategory.nutrition:
        return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create New Habit',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Habit Name',
                  hintText: 'e.g. Read 20 pages',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.bookmark_border),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: 'Description / Goal',
                  hintText: 'e.g. Daily morning routine',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Category',
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: HabitCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  final catColor = _getCategoryColor(cat);
                  return ChoiceChip(
                    label: Text(
                      cat.name[0].toUpperCase() + cat.name.substring(1),
                      style: TextStyle(
                        color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: catColor,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = cat);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Target Days: $_targetDays / week',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Slider(
                value: _targetDays.toDouble(),
                min: 1,
                max: 7,
                divisions: 6,
                label: '$_targetDays days',
                activeColor: _getCategoryColor(_selectedCategory),
                onChanged: (val) {
                  setState(() => _targetDays = val.toInt());
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onAdd(
                      title: _titleController.text.trim(),
                      description: _descController.text.trim().isEmpty
                          ? 'Consistent daily habit'
                          : _descController.text.trim(),
                      category: _selectedCategory,
                      targetDays: _targetDays,
                      icon: _getCategoryIcon(_selectedCategory),
                      color: _getCategoryColor(_selectedCategory),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  'Add Habit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
