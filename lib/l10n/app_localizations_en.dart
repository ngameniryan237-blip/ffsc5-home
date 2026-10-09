// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Zenith Wellness';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navHabits => 'Habits';

  @override
  String get navWorkouts => 'Workouts';

  @override
  String get navStore => 'Market';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get navSettings => 'Settings';

  @override
  String get dashboardTitle => 'Today\'s Journey';

  @override
  String get dashboardSubtitle => 'Keep your momentum going';

  @override
  String dailyStreak(int count) {
    return '$count Day Streak';
  }

  @override
  String get activityScore => 'Daily Activity';

  @override
  String completionRate(int rate) {
    return '$rate% completed';
  }

  @override
  String get todayHabits => 'Today\'s Habits';

  @override
  String get viewAll => 'View All';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get logWater => 'Log Water';

  @override
  String get logCalories => 'Log Calories';

  @override
  String get startWorkout => 'Start Workout';

  @override
  String waterLogged(int amount) {
    return 'Water: ${amount}ml';
  }

  @override
  String caloriesBurned(int calories) {
    return 'Burned: $calories kcal';
  }

  @override
  String activeMinutes(int minutes) {
    return 'Active: $minutes mins';
  }

  @override
  String get habitsTitle => 'Habit Tracker';

  @override
  String get allHabits => 'All';

  @override
  String get habitCategoryMind => 'Mindfulness';

  @override
  String get habitCategoryBody => 'Fitness';

  @override
  String get habitCategoryProductivity => 'Productivity';

  @override
  String get habitCategoryNutrition => 'Nutrition';

  @override
  String get addHabit => 'Add Habit';

  @override
  String get editHabit => 'Edit Habit';

  @override
  String get habitName => 'Habit Name';

  @override
  String get habitCategory => 'Category';

  @override
  String get habitTargetDays => 'Target Days per Week';

  @override
  String get habitCreated => 'Habit created successfully';

  @override
  String get habitDeleted => 'Habit deleted';

  @override
  String get noHabitsFound => 'No habits found. Tap + to add one!';

  @override
  String get markComplete => 'Mark as completed';

  @override
  String get markIncomplete => 'Mark as incomplete';

  @override
  String streakDays(int streak) {
    return '$streak days';
  }

  @override
  String get workoutsTitle => 'Workout Studio';

  @override
  String get searchWorkouts => 'Search workouts...';

  @override
  String get filterAll => 'All Workouts';

  @override
  String get filterHiit => 'HIIT';

  @override
  String get filterYoga => 'Yoga';

  @override
  String get filterStrength => 'Strength';

  @override
  String get filterCardio => 'Cardio';

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get intensityEasy => 'Beginner';

  @override
  String get intensityMedium => 'Intermediate';

  @override
  String get intensityHard => 'Advanced';

  @override
  String get startSession => 'Start Session';

  @override
  String get pauseSession => 'Pause';

  @override
  String get resumeSession => 'Resume';

  @override
  String get finishSession => 'Finish Workout';

  @override
  String get workoutCompleted => 'Workout Completed!';

  @override
  String caloriesEarned(int calories) {
    return 'You burned $calories calories';
  }

  @override
  String get noWorkoutsFound => 'No workouts match your filter';

  @override
  String get storeTitle => 'Wellness Marketplace';

  @override
  String get searchProducts => 'Search gear, supplements...';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryNutrition => 'Nutrition';

  @override
  String get categoryEquipment => 'Equipment';

  @override
  String get categoryApparel => 'Apparel';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get cartTitle => 'Shopping Cart';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get discount => 'Discount';

  @override
  String get tax => 'Estimated Tax (5%)';

  @override
  String get total => 'Total';

  @override
  String get promoCode => 'Promo Code';

  @override
  String get apply => 'Apply';

  @override
  String get promoApplied => '20% Discount applied!';

  @override
  String get promoInvalid => 'Invalid promo code';

  @override
  String get checkout => 'Proceed to Checkout';

  @override
  String get orderSuccessful => 'Order Placed Successfully!';

  @override
  String get orderMessage => 'Thank you for supporting your wellness journey.';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get analyticsTitle => 'Performance Analytics';

  @override
  String get weeklyOverview => 'Weekly Consistency';

  @override
  String get completionTrend => 'Habit Completion Trend';

  @override
  String get categoryDistribution => 'Focus Distribution';

  @override
  String weeklyAverage(int rate) {
    return 'Weekly Average: $rate%';
  }

  @override
  String totalWorkoutsDone(int count) {
    return 'Workouts Completed: $count';
  }

  @override
  String totalMinutesExercised(int mins) {
    return 'Total Exercise Time: ${mins}m';
  }

  @override
  String get settingsTitle => 'Settings & Preferences';

  @override
  String get preferences => 'Preferences';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get themeSystem => 'System Default';

  @override
  String get themeLight => 'Light Mode';

  @override
  String get themeDark => 'Dark Mode';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get highContrast => 'High Contrast Mode';

  @override
  String get reduceAnimations => 'Reduce Animations';

  @override
  String get account => 'Account & Data';

  @override
  String get resetData => 'Reset Sample Data';

  @override
  String get resetDataConfirm =>
      'Are you sure you want to reset all habits and progress?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get dataResetSuccess => 'Data reset to defaults';

  @override
  String get aboutApp => 'About Zenith';

  @override
  String get appVersion => 'Version 1.2.0 (Production)';

  @override
  String get developedBy =>
      'Built with Flutter for high performance and accessibility.';
}
