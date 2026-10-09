import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _waterLoggedMl = 1750;
  final int _waterGoalMl = 2500;

  int _caloriesBurned = 420;
  final int _caloriesGoal = 600;

  int _activeMinutes = 35;
  final int _activeMinutesGoal = 45;

  int get waterLoggedMl => _waterLoggedMl;
  int get waterGoalMl => _waterGoalMl;
  double get waterProgress => (_waterLoggedMl / _waterGoalMl).clamp(0.0, 1.0);

  int get caloriesBurned => _caloriesBurned;
  int get caloriesGoal => _caloriesGoal;
  double get caloriesProgress => (_caloriesBurned / _caloriesGoal).clamp(0.0, 1.0);

  int get activeMinutes => _activeMinutes;
  int get activeMinutesGoal => _activeMinutesGoal;
  double get activeMinutesProgress => (_activeMinutes / _activeMinutesGoal).clamp(0.0, 1.0);

  void logWater([int amount = 250]) {
    _waterLoggedMl = (_waterLoggedMl + amount).clamp(0, 5000);
    notifyListeners();
  }

  void logCalories([int amount = 150]) {
    _caloriesBurned = (_caloriesBurned + amount).clamp(0, 2000);
    notifyListeners();
  }

  void addActiveMinutes([int minutes = 15]) {
    _activeMinutes = (_activeMinutes + minutes).clamp(0, 300);
    notifyListeners();
  }

  void resetDefaults() {
    _waterLoggedMl = 1750;
    _caloriesBurned = 420;
    _activeMinutes = 35;
    notifyListeners();
  }
}
