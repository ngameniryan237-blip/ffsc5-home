import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Zenith Wellness'**
  String get appName;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get navHabits;

  /// No description provided for @navWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get navWorkouts;

  /// No description provided for @navStore.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get navStore;

  /// No description provided for @navAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get navAnalytics;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Journey'**
  String get dashboardTitle;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your momentum going'**
  String get dashboardSubtitle;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'{count} Day Streak'**
  String dailyStreak(int count);

  /// No description provided for @activityScore.
  ///
  /// In en, this message translates to:
  /// **'Daily Activity'**
  String get activityScore;

  /// No description provided for @completionRate.
  ///
  /// In en, this message translates to:
  /// **'{rate}% completed'**
  String completionRate(int rate);

  /// No description provided for @todayHabits.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Habits'**
  String get todayHabits;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @logWater.
  ///
  /// In en, this message translates to:
  /// **'Log Water'**
  String get logWater;

  /// No description provided for @logCalories.
  ///
  /// In en, this message translates to:
  /// **'Log Calories'**
  String get logCalories;

  /// No description provided for @startWorkout.
  ///
  /// In en, this message translates to:
  /// **'Start Workout'**
  String get startWorkout;

  /// No description provided for @waterLogged.
  ///
  /// In en, this message translates to:
  /// **'Water: {amount}ml'**
  String waterLogged(int amount);

  /// No description provided for @caloriesBurned.
  ///
  /// In en, this message translates to:
  /// **'Burned: {calories} kcal'**
  String caloriesBurned(int calories);

  /// No description provided for @activeMinutes.
  ///
  /// In en, this message translates to:
  /// **'Active: {minutes} mins'**
  String activeMinutes(int minutes);

  /// No description provided for @habitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit Tracker'**
  String get habitsTitle;

  /// No description provided for @allHabits.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allHabits;

  /// No description provided for @habitCategoryMind.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get habitCategoryMind;

  /// No description provided for @habitCategoryBody.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get habitCategoryBody;

  /// No description provided for @habitCategoryProductivity.
  ///
  /// In en, this message translates to:
  /// **'Productivity'**
  String get habitCategoryProductivity;

  /// No description provided for @habitCategoryNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get habitCategoryNutrition;

  /// No description provided for @addHabit.
  ///
  /// In en, this message translates to:
  /// **'Add Habit'**
  String get addHabit;

  /// No description provided for @editHabit.
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabit;

  /// No description provided for @habitName.
  ///
  /// In en, this message translates to:
  /// **'Habit Name'**
  String get habitName;

  /// No description provided for @habitCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get habitCategory;

  /// No description provided for @habitTargetDays.
  ///
  /// In en, this message translates to:
  /// **'Target Days per Week'**
  String get habitTargetDays;

  /// No description provided for @habitCreated.
  ///
  /// In en, this message translates to:
  /// **'Habit created successfully'**
  String get habitCreated;

  /// No description provided for @habitDeleted.
  ///
  /// In en, this message translates to:
  /// **'Habit deleted'**
  String get habitDeleted;

  /// No description provided for @noHabitsFound.
  ///
  /// In en, this message translates to:
  /// **'No habits found. Tap + to add one!'**
  String get noHabitsFound;

  /// No description provided for @markComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as completed'**
  String get markComplete;

  /// No description provided for @markIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as incomplete'**
  String get markIncomplete;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{streak} days'**
  String streakDays(int streak);

  /// No description provided for @workoutsTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout Studio'**
  String get workoutsTitle;

  /// No description provided for @searchWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Search workouts...'**
  String get searchWorkouts;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All Workouts'**
  String get filterAll;

  /// No description provided for @filterHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get filterHiit;

  /// No description provided for @filterYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get filterYoga;

  /// No description provided for @filterStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get filterStrength;

  /// No description provided for @filterCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get filterCardio;

  /// No description provided for @durationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationMinutes(int minutes);

  /// No description provided for @intensityEasy.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get intensityEasy;

  /// No description provided for @intensityMedium.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intensityMedium;

  /// No description provided for @intensityHard.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get intensityHard;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get startSession;

  /// No description provided for @pauseSession.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseSession;

  /// No description provided for @resumeSession.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeSession;

  /// No description provided for @finishSession.
  ///
  /// In en, this message translates to:
  /// **'Finish Workout'**
  String get finishSession;

  /// No description provided for @workoutCompleted.
  ///
  /// In en, this message translates to:
  /// **'Workout Completed!'**
  String get workoutCompleted;

  /// No description provided for @caloriesEarned.
  ///
  /// In en, this message translates to:
  /// **'You burned {calories} calories'**
  String caloriesEarned(int calories);

  /// No description provided for @noWorkoutsFound.
  ///
  /// In en, this message translates to:
  /// **'No workouts match your filter'**
  String get noWorkoutsFound;

  /// No description provided for @storeTitle.
  ///
  /// In en, this message translates to:
  /// **'Wellness Marketplace'**
  String get storeTitle;

  /// No description provided for @searchProducts.
  ///
  /// In en, this message translates to:
  /// **'Search gear, supplements...'**
  String get searchProducts;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryNutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get categoryNutrition;

  /// No description provided for @categoryEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get categoryEquipment;

  /// No description provided for @categoryApparel.
  ///
  /// In en, this message translates to:
  /// **'Apparel'**
  String get categoryApparel;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get cartTitle;

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCart;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Estimated Tax (5%)'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @promoApplied.
  ///
  /// In en, this message translates to:
  /// **'20% Discount applied!'**
  String get promoApplied;

  /// No description provided for @promoInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid promo code'**
  String get promoInvalid;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get checkout;

  /// No description provided for @orderSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderSuccessful;

  /// No description provided for @orderMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for supporting your wellness journey.'**
  String get orderMessage;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance Analytics'**
  String get analyticsTitle;

  /// No description provided for @weeklyOverview.
  ///
  /// In en, this message translates to:
  /// **'Weekly Consistency'**
  String get weeklyOverview;

  /// No description provided for @completionTrend.
  ///
  /// In en, this message translates to:
  /// **'Habit Completion Trend'**
  String get completionTrend;

  /// No description provided for @categoryDistribution.
  ///
  /// In en, this message translates to:
  /// **'Focus Distribution'**
  String get categoryDistribution;

  /// No description provided for @weeklyAverage.
  ///
  /// In en, this message translates to:
  /// **'Weekly Average: {rate}%'**
  String weeklyAverage(int rate);

  /// No description provided for @totalWorkoutsDone.
  ///
  /// In en, this message translates to:
  /// **'Workouts Completed: {count}'**
  String totalWorkoutsDone(int count);

  /// No description provided for @totalMinutesExercised.
  ///
  /// In en, this message translates to:
  /// **'Total Exercise Time: {mins}m'**
  String totalMinutesExercised(int mins);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get settingsTitle;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get french;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDark;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High Contrast Mode'**
  String get highContrast;

  /// No description provided for @reduceAnimations.
  ///
  /// In en, this message translates to:
  /// **'Reduce Animations'**
  String get reduceAnimations;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account & Data'**
  String get account;

  /// No description provided for @resetData.
  ///
  /// In en, this message translates to:
  /// **'Reset Sample Data'**
  String get resetData;

  /// No description provided for @resetDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all habits and progress?'**
  String get resetDataConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @dataResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data reset to defaults'**
  String get dataResetSuccess;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Zenith'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.2.0 (Production)'**
  String get appVersion;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Built with Flutter for high performance and accessibility.'**
  String get developedBy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
