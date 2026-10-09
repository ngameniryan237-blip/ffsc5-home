import 'dart:async';
import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutProvider extends ChangeNotifier {
  List<Workout> _workouts = [];
  WorkoutType? _selectedType;
  String _searchQuery = '';

  // Active Session state
  Workout? _activeWorkout;
  int _sessionSecondsRemaining = 0;
  bool _isSessionRunning = false;
  Timer? _timer;
  int _completedWorkoutsCount = 4;
  int _totalCaloriesBurned = 1450;
  int _totalMinutesExercised = 120;

  WorkoutProvider() {
    _initWorkouts();
  }

  List<Workout> get workouts => List.unmodifiable(_workouts);
  WorkoutType? get selectedType => _selectedType;
  String get searchQuery => _searchQuery;

  Workout? get activeWorkout => _activeWorkout;
  int get sessionSecondsRemaining => _sessionSecondsRemaining;
  bool get isSessionRunning => _isSessionRunning;
  int get completedWorkoutsCount => _completedWorkoutsCount;
  int get totalCaloriesBurned => _totalCaloriesBurned;
  int get totalMinutesExercised => _totalMinutesExercised;

  List<Workout> get filteredWorkouts {
    return _workouts.where((w) {
      final matchesType = _selectedType == null || w.type == _selectedType;
      final matchesSearch = _searchQuery.isEmpty ||
          w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  void setTypeFilter(WorkoutType? type) {
    if (_selectedType == type) {
      _selectedType = null;
    } else {
      _selectedType = type;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void startSession(Workout workout) {
    _timer?.cancel();
    _activeWorkout = workout;
    _sessionSecondsRemaining = workout.durationMinutes * 60;
    _isSessionRunning = true;
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sessionSecondsRemaining > 0) {
        _sessionSecondsRemaining--;
        notifyListeners();
      } else {
        finishSession();
      }
    });
  }

  void pauseSession() {
    _timer?.cancel();
    _isSessionRunning = false;
    notifyListeners();
  }

  void resumeSession() {
    if (_activeWorkout != null && _sessionSecondsRemaining > 0) {
      _isSessionRunning = true;
      _startTimer();
      notifyListeners();
    }
  }

  void finishSession() {
    _timer?.cancel();
    if (_activeWorkout != null) {
      _completedWorkoutsCount++;
      _totalCaloriesBurned += _activeWorkout!.estimatedCalories;
      _totalMinutesExercised += _activeWorkout!.durationMinutes;
    }
    _isSessionRunning = false;
    _sessionSecondsRemaining = 0;
    notifyListeners();
  }

  void resetSession() {
    _timer?.cancel();
    _activeWorkout = null;
    _sessionSecondsRemaining = 0;
    _isSessionRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initWorkouts() {
    _workouts = [
      const Workout(
        id: 'w1',
        title: 'Full Body HIIT Inferno',
        description: 'High intensity interval circuit burning maximum calories in 25 mins.',
        type: WorkoutType.hiit,
        intensity: WorkoutIntensity.hard,
        durationMinutes: 25,
        estimatedCalories: 320,
        exercises: [
          'Jumping Jacks (45s)',
          'Mountain Climbers (45s)',
          'Burpees (45s)',
          'High Knees (45s)',
          'Plank to Push-up (45s)',
        ],
        icon: Icons.bolt,
        accentColor: Color(0xFFF43F5E),
      ),
      const Workout(
        id: 'w2',
        title: 'Morning Vinyasa Flow',
        description: 'Energizing yoga sequence for flexibility, spinal mobility, and breath.',
        type: WorkoutType.yoga,
        intensity: WorkoutIntensity.easy,
        durationMinutes: 20,
        estimatedCalories: 140,
        exercises: [
          'Cat-Cow Stretches',
          'Downward Facing Dog',
          'Sun Salutation A',
          'Warrior II Pose',
          'Child Pose Relaxation',
        ],
        icon: Icons.self_improvement,
        accentColor: Color(0xFF8B5CF6),
      ),
      const Workout(
        id: 'w3',
        title: 'Core & Upper Strength',
        description: 'Focused resistance routine targeting abs, chest, back, and shoulders.',
        type: WorkoutType.strength,
        intensity: WorkoutIntensity.medium,
        durationMinutes: 30,
        estimatedCalories: 260,
        exercises: [
          'Push-ups (3x12)',
          'Dumbbell Rows (3x10)',
          'Bicycle Crunches (3x20)',
          'Side Plank Holds (3x30s)',
        ],
        icon: Icons.fitness_center,
        accentColor: Color(0xFF10B981),
      ),
      const Workout(
        id: 'w4',
        title: 'Outdoor / Treadmill Cardio Blast',
        description: 'Progressive pace intervals designed to boost VO2 max & endurance.',
        type: WorkoutType.cardio,
        intensity: WorkoutIntensity.medium,
        durationMinutes: 35,
        estimatedCalories: 380,
        exercises: [
          'Dynamic Warmup (5m)',
          'Tempo Intervals (20m)',
          'Sprint Surges (5m)',
          'Cool Down Walk (5m)',
        ],
        icon: Icons.directions_run,
        accentColor: Color(0xFF06B6D4),
      ),
    ];
  }
}
