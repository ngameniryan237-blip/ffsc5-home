# 🌿 Zenith Wellness & Habit Tracker

[![Flutter CI](https://github.com/ngameniryan237-blip/ffsc5-home/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/ngameniryan237-blip/ffsc5-home/actions)
[![Flutter](https://img.shields.io/badge/Flutter-3.38+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.2.0-blue.svg)](CHANGELOG.md)
[![Tests](https://img.shields.io/badge/tests-35%20passed-success.svg)](test)
[![Static Analysis](https://img.shields.io/badge/flutter%20analyze-clean%200%20issues-brightgreen.svg)](analysis_options.yaml)

A tested, optimized, production-ready Flutter application delivering a smart habit tracking, workout coaching, analytics, and wellness marketplace platform. Built with **Clean Feature-First Architecture**, **WCAG Accessibility Semantics**, **English & French Internationalization (i18n)**, **60fps jank-free performance optimizations**, and a **35-test automated suite** with continuous integration via GitHub Actions.

---

## 📱 Application Screens & Features

Zenith features **6 complete production screens** accessible through a smooth bottom navigation bar:

1. **🌟 Dashboard / Today's Journey**:
   - Live **Activity Rings** (Concentric custom-painted rings for Calories, Exercise Minutes, and Hydration).
   - Streak achievement banner with real-time completion percentages.
   - Quick action logging chips (`+250ml Water`, `+150 kcal`, `+15m Exercise`).
   - Daily habits check-in strip and featured workout launcher.

2. **✅ Habit Tracker**:
   - Daily checklist with streak counts and flame badges.
   - Category filtering (`Mindfulness`, `Fitness`, `Productivity`, `Nutrition`).
   - Custom habit creation bottom sheet with category selectors and target frequency slider.
   - Strike-through micro-animations and streak preservation logic.

3. **⚡ Workout Studio & Active Player**:
   - Categorized routines (`HIIT`, `Yoga`, `Strength`, `Cardio`) with search and difficulty filters.
   - Interactive workout session player with circular progress timer, exercise circuit steps, play/pause/finish controls, and calorie burn celebration dialog.

4. **🛍️ Wellness Marketplace & Cart**:
   - Product catalog with live search, rating badges, and category filters.
   - Shopping cart with quantity steppers, item removal, and subtotal calculations.
   - Promo discount engine (`ZENITH20` for 20% off, `WELCOME10` for 10% off) + 5% estimated tax calculation.
   - Complete checkout summary flow with confirmation dialog.

5. **📊 Performance Analytics & Insights**:
   - Weekly consistency bar chart rendered via optimized custom painters.
   - Focus distribution progress breakdown across categories.
   - Dynamic health score calculation algorithm.

6. **⚙️ Settings & Accessibility Preferences**:
   - **Real-Time Language Switcher**: Instant switching between **English** and **Français**.
   - **Theme Mode**: System Default, Light Mode, and Dark Mode.
   - **Accessibility Controls**: High Contrast mode (WCAG AA/AAA compliant borders & contrasts) and Reduced Motion mode.
   - **Data Management**: Sample data reset with confirmation dialog.

---

## 🏗️ Architecture & Project Structure

The codebase is organized following **Clean Feature-First Architecture**:

```
lib/
├── app.dart                        # MultiProvider root & MaterialApp setup
├── app_shell.dart                  # Bottom navigation & IndexedStack screen switcher
├── main.dart                       # App entrypoint
├── core/
│   ├── accessibility/              # Semantic helpers & accessibility utilities
│   ├── theme/                      # AppColors palette & AppTheme (Light, Dark, High Contrast)
│   └── widgets/                    # Reusable components (MetricCard, SectionHeader, EmptyStateView)
├── features/
│   ├── dashboard/                  # Dashboard screen, providers, and ActivityRingPainter
│   ├── habits/                     # Habit models, HabitProvider, HabitCard, AddHabitDialog
│   ├── workouts/                   # Workout models, WorkoutProvider, WorkoutCard, SessionPlayer
│   ├── store/                      # Product & Cart models, StoreProvider, ProductCard, CartScreen
│   ├── analytics/                  # AnalyticsProvider, AnalyticsScreen, WeeklyChartPainter
│   └── settings/                   # SettingsProvider & SettingsScreen
└── l10n/
    ├── app_en.arb                  # English translation dictionary
    ├── app_fr.arb                  # French translation dictionary
    └── app_localizations.dart      # Generated localization bindings
```

---

## 🚀 Performance & Optimization Highlights

- **Zero Visible Jank (Locked 60fps)**:
  - Complex custom graphics (`ActivityRingPainter` and `WeeklyChartPainter`) are enclosed within `RepaintBoundary` widgets to isolate repaint subtrees.
  - Screen transitions utilize `IndexedStack` to preserve state without causing redundant page rebuilds.
- **Granular State Management**:
  - Built using `Provider` with isolated `ChangeNotifier` scopes per feature domain.
- **Const Construction**:
  - `const` constructors are enforced across all static widgets and styles via strict static analysis.
- **Virtualization**:
  - All lists and grids use `ListView.builder` and `GridView.builder` to guarantee lazy-loading and memory recycling.

---

## ♿ Accessibility & 🌐 Internationalization

### Accessibility (a11y)
- **WCAG Semantics**: All interactive buttons, habit checkmarks, quantity adjusters, and cards include `Semantics` tags with explicit labels, toggled states, and screen reader hints.
- **Touch Targets**: Minimum touch target size (48x48dp) maintained for all interactive elements.
- **High Contrast Mode**: Toggleable dedicated high-contrast palette with solid borders and high-visibility contrast ratios.

### Internationalization (i18n)
- 100% text strings externalized into ARB localization dictionaries (`app_en.arb` and `app_fr.arb`).
- Real-time language switching without requiring an app restart.

---

## 🧪 Comprehensive Test Suite

The project includes **35 automated tests** covering unit logic, widget rendering, and integration user flows:

| Test Category | File | Description |
|---|---|---|
| **Unit** | [`habit_provider_test.dart`](test/unit/habit_provider_test.dart) | Habit creation, streak calculations, toggle completion, deletion, category filtering |
| **Unit** | [`workout_provider_test.dart`](test/unit/workout_provider_test.dart) | Workout filters, search query parsing, session timer, calorie burn tracking |
| **Unit** | [`store_provider_test.dart`](test/unit/store_provider_test.dart) | Cart quantity stepper, subtotal/tax math, `ZENITH20` & `WELCOME10` promo codes |
| **Unit** | [`settings_provider_test.dart`](test/unit/settings_provider_test.dart) | Locale switching (EN/FR), theme modes, high contrast, and animation settings |
| **Unit** | [`analytics_test.dart`](test/unit/analytics_test.dart) | Health score algorithm, weekly completion averages, category distributions |
| **Widget** | [`habit_card_test.dart`](test/widget/habit_card_test.dart) | Visual rendering, streak badges, strike-through, checkmark toggle interaction |
| **Widget** | [`metric_card_test.dart`](test/widget/metric_card_test.dart) | Metric values, titles, subtitles, icons, accessibility semantics |
| **Widget** | [`workout_card_test.dart`](test/widget/workout_card_test.dart) | Workout details, difficulty badges, duration, play button navigation |
| **Widget** | [`cart_item_tile_test.dart`](test/widget/cart_item_tile_test.dart) | Product info, quantity increase/decrease buttons, item removal |
| **Widget** | [`empty_state_test.dart`](test/widget/empty_state_test.dart) | Localized empty view rendering and action button callbacks |
| **Widget** | [`app_smoke_test.dart`](test/widget/app_smoke_test.dart) | App initialization and navigation across all 6 bottom tabs |
| **Integration** | [`habit_flow_integration_test.dart`](test/integration/habit_flow_integration_test.dart) | Complete user flow: toggle habit on dashboard, create habit, switch language to French |
| **Integration** | [`store_checkout_integration_test.dart`](test/integration/store_checkout_integration_test.dart) | Complete user flow: browse catalog, add item, apply promo code, complete checkout |

---

## 🛠️ Setup & Execution Guide

### Prerequisites
- Flutter SDK (version 3.20.0 or higher)
- Dart SDK (version 3.10.0 or higher)

### Installation
```bash
# 1. Clone repository
git clone https://github.com/ngameniryan237-blip/ffsc5-home.git
cd "project 5"

# 2. Install dependencies
flutter pub get

# 3. Generate localizations
flutter gen-l10n

# 4. Run static analysis (0 issues)
flutter analyze

# 5. Run automated test suite
flutter test

# 6. Launch application
flutter run
```

---

## 🔄 CI/CD Pipeline

Continuous integration is automated via GitHub Actions on every pull request and push to `main`:
- **Step 1**: Sets up Flutter environment and caches dependencies.
- **Step 2**: Executes `flutter analyze --fatal-infos` (enforcing 0 warnings/lints).
- **Step 3**: Runs the automated test suite with coverage report generation (`flutter test --coverage`).
- **Step 4**: Uploads coverage artifacts.

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
# ffsc5-home
