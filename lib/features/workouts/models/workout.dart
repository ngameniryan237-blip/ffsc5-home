import 'package:flutter/material.dart';

enum WorkoutIntensity {
  easy,
  medium,
  hard,
}

enum WorkoutType {
  hiit,
  yoga,
  strength,
  cardio,
}

class Workout {
  final String id;
  final String title;
  final String description;
  final WorkoutType type;
  final WorkoutIntensity intensity;
  final int durationMinutes;
  final int estimatedCalories;
  final List<String> exercises;
  final IconData icon;
  final Color accentColor;

  const Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.intensity,
    required this.durationMinutes,
    required this.estimatedCalories,
    required this.exercises,
    this.icon = Icons.fitness_center,
    this.accentColor = const Color(0xFF10B981),
  });
}
