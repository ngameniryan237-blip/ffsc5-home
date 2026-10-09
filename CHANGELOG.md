# Changelog

All notable changes to the **Zenith Wellness & Habit Tracker** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.2.0] - 2026-09-05

### Added
- **Internationalization (i18n)**: Full English (EN) and French (FR) translation coverage via Flutter's `gen-l10n` toolchain and `.arb` bundles.
- **Accessibility Enhancements (a11y)**:
  - Added semantic labels (`Semantics`), explicit hints, and touch target optimization for screen readers (TalkBack / VoiceOver).
  - High Contrast mode support with dedicated color palette tokens for WCAG AA/AAA compliance.
  - Motion sensitivity support (`reduceAnimations` toggle).
- **Comprehensive Automated Test Suite**:
  - 10+ Unit Tests across Habit, Workout, Store, Settings, and Analytics state providers.
  - 5+ Widget Tests verifying rendering, user interactions, and visual states.
  - 2+ Full-Journey Integration Tests simulating real user workflows.
- **CI/CD Automation**: GitHub Actions workflow running static analysis (`flutter analyze --fatal-infos`) and automated tests with code coverage report uploads.

### Optimized
- Eliminated all unnecessary widget rebuilds using `IndexedStack`, granular `ChangeNotifierProvider` selectors, and `const` constructors.
- Isolated canvas rendering for concentric Activity Rings and Weekly Analytics bar charts inside `RepaintBoundary` nodes for locked 60fps performance.

---

## [1.1.0] - 2026-08-20

### Added
- **Wellness Marketplace**:
  - Categorized catalog (Nutrition, Equipment, Apparel) with search and filter capabilities.
  - Interactive shopping cart with quantity stepping, subtotal, tax calculation (5%), and promo code engine (`ZENITH20`, `WELCOME10`).
  - Checkout confirmation and order success dialog.
- **Analytics & Insights**:
  - Weekly habit consistency bar charts with custom canvas rendering.
  - Category breakdown distribution with progress indicators.
  - Dynamic Health Score calculation engine based on habits, workouts, and hydration logs.

### Changed
- Refactored state architecture to Clean Feature-First modular structure.

---

## [1.0.0] - 2026-08-01

### Added
- **Dashboard Screen**:
  - Concentric triple activity rings for Active Calories, Exercise Minutes, and Hydration.
  - Streak tracking banner with real-time completion percentages.
  - Quick action logging chips (+250ml water, +150 kcal, +15m exercise).
- **Habit Tracker**:
  - Daily checklist with streak counts and category filtering (Mind, Body, Productivity, Nutrition).
  - Add Custom Habit dialog with category chips and frequency slider.
- **Workout Studio**:
  - Workout routine catalog across HIIT, Yoga, Strength, and Cardio.
  - Active Workout Player with interactive countdown timer, pause/resume controls, exercise circuit checklist, and calories earned summary.
- Initial project scaffolding, theming system (Dark & Light modes), and typography.
