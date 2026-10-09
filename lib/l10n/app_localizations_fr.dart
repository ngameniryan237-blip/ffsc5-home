// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Zenith Bien-Être';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navHabits => 'Habitudes';

  @override
  String get navWorkouts => 'Entraînements';

  @override
  String get navStore => 'Boutique';

  @override
  String get navAnalytics => 'Analyses';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get dashboardTitle => 'Parcours du Jour';

  @override
  String get dashboardSubtitle => 'Maintenez votre élan';

  @override
  String dailyStreak(int count) {
    return 'Série de $count jours';
  }

  @override
  String get activityScore => 'Activité Quotidienne';

  @override
  String completionRate(int rate) {
    return '$rate% complété';
  }

  @override
  String get todayHabits => 'Habitudes d\'aujourd\'hui';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get quickActions => 'Actions Rapides';

  @override
  String get logWater => 'Ajouter Eau';

  @override
  String get logCalories => 'Ajouter Calories';

  @override
  String get startWorkout => 'Démarrer Séance';

  @override
  String waterLogged(int amount) {
    return 'Eau : ${amount}ml';
  }

  @override
  String caloriesBurned(int calories) {
    return 'Brûlées : $calories kcal';
  }

  @override
  String activeMinutes(int minutes) {
    return 'Actif : $minutes mins';
  }

  @override
  String get habitsTitle => 'Suivi des Habitudes';

  @override
  String get allHabits => 'Toutes';

  @override
  String get habitCategoryMind => 'Pleine Conscience';

  @override
  String get habitCategoryBody => 'Forme Physique';

  @override
  String get habitCategoryProductivity => 'Productivité';

  @override
  String get habitCategoryNutrition => 'Nutrition';

  @override
  String get addHabit => 'Ajouter Habitude';

  @override
  String get editHabit => 'Modifier Habitude';

  @override
  String get habitName => 'Nom de l\'habitude';

  @override
  String get habitCategory => 'Catégorie';

  @override
  String get habitTargetDays => 'Jours cibles par semaine';

  @override
  String get habitCreated => 'Habitude créée avec succès';

  @override
  String get habitDeleted => 'Habitude supprimée';

  @override
  String get noHabitsFound =>
      'Aucune habitude trouvée. Appuyez sur + pour en créer une !';

  @override
  String get markComplete => 'Marquer comme terminé';

  @override
  String get markIncomplete => 'Marquer comme non terminé';

  @override
  String streakDays(int streak) {
    return '$streak jours';
  }

  @override
  String get workoutsTitle => 'Studio d\'Entraînement';

  @override
  String get searchWorkouts => 'Rechercher un entraînement...';

  @override
  String get filterAll => 'Tous les entraînements';

  @override
  String get filterHiit => 'HIIT';

  @override
  String get filterYoga => 'Yoga';

  @override
  String get filterStrength => 'Musculation';

  @override
  String get filterCardio => 'Cardio';

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get intensityEasy => 'Débutant';

  @override
  String get intensityMedium => 'Intermédiaire';

  @override
  String get intensityHard => 'Avancé';

  @override
  String get startSession => 'Commencer la séance';

  @override
  String get pauseSession => 'Pause';

  @override
  String get resumeSession => 'Reprendre';

  @override
  String get finishSession => 'Terminer l\'entraînement';

  @override
  String get workoutCompleted => 'Entraînement Terminé !';

  @override
  String caloriesEarned(int calories) {
    return 'Vous avez brûlé $calories calories';
  }

  @override
  String get noWorkoutsFound =>
      'Aucun entraînement ne correspond à votre filtre';

  @override
  String get storeTitle => 'Boutique Bien-Être';

  @override
  String get searchProducts => 'Rechercher équipements, compléments...';

  @override
  String get categoryAll => 'Tous';

  @override
  String get categoryNutrition => 'Nutrition';

  @override
  String get categoryEquipment => 'Équipement';

  @override
  String get categoryApparel => 'Vêtements';

  @override
  String get addToCart => 'Ajouter au Panier';

  @override
  String get addedToCart => 'Ajouté au panier';

  @override
  String get cartTitle => 'Panier d\'Achat';

  @override
  String get emptyCart => 'Votre panier est vide';

  @override
  String get subtotal => 'Sous-total';

  @override
  String get discount => 'Remise';

  @override
  String get tax => 'Taxe estimée (5%)';

  @override
  String get total => 'Total';

  @override
  String get promoCode => 'Code Promo';

  @override
  String get apply => 'Appliquer';

  @override
  String get promoApplied => 'Remise de 20% appliquée !';

  @override
  String get promoInvalid => 'Code promo invalide';

  @override
  String get checkout => 'Passer la commande';

  @override
  String get orderSuccessful => 'Commande Passée avec Succès !';

  @override
  String get orderMessage => 'Merci de soutenir votre parcours bien-être.';

  @override
  String itemsCount(int count) {
    return '$count articles';
  }

  @override
  String get analyticsTitle => 'Analyses de Performance';

  @override
  String get weeklyOverview => 'Régularité Hebdomadaire';

  @override
  String get completionTrend => 'Tendance de Réalisation';

  @override
  String get categoryDistribution => 'Répartition des Objectifs';

  @override
  String weeklyAverage(int rate) {
    return 'Moyenne Hebdomadaire : $rate%';
  }

  @override
  String totalWorkoutsDone(int count) {
    return 'Entraînements Complétés : $count';
  }

  @override
  String totalMinutesExercised(int mins) {
    return 'Temps Total d\'Exercice : ${mins}m';
  }

  @override
  String get settingsTitle => 'Paramètres & Préférences';

  @override
  String get preferences => 'Préférences';

  @override
  String get language => 'Langue';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get themeMode => 'Mode Thème';

  @override
  String get themeSystem => 'Défaut Système';

  @override
  String get themeLight => 'Mode Clair';

  @override
  String get themeDark => 'Mode Sombre';

  @override
  String get accessibility => 'Accessibilité';

  @override
  String get highContrast => 'Mode Contraste Élevé';

  @override
  String get reduceAnimations => 'Réduire les Animations';

  @override
  String get account => 'Compte & Données';

  @override
  String get resetData => 'Réinitialiser les Données';

  @override
  String get resetDataConfirm =>
      'Voulez-vous vraiment réinitialiser toutes les habitudes ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get dataResetSuccess => 'Données réinitialisées';

  @override
  String get aboutApp => 'À propos de Zenith';

  @override
  String get appVersion => 'Version 1.2.0 (Production)';

  @override
  String get developedBy =>
      'Conçu avec Flutter pour une haute performance et accessibilité.';
}
