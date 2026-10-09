import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/habits/presentation/screens/habits_screen.dart';
import 'features/workouts/presentation/screens/workouts_screen.dart';
import 'features/store/presentation/screens/store_screen.dart';
import 'features/analytics/presentation/screens/analytics_screen.dart';
import 'features/settings/presentation/screens/settings_screen.dart';
import 'features/store/providers/store_provider.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final storeProvider = context.watch<StoreProvider>();
    final cartCount = storeProvider.totalItemCount;

    final screens = <Widget>[
      DashboardScreen(onNavigateTab: _onTabSelected),
      const HabitsScreen(),
      const WorkoutsScreen(),
      const StoreScreen(),
      const AnalyticsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: l10n.navDashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check_circle_outline),
            activeIcon: const Icon(Icons.check_circle),
            label: l10n.navHabits,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center_outlined),
            activeIcon: const Icon(Icons.fitness_center),
            label: l10n.navWorkouts,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.storefront_outlined),
            ),
            activeIcon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              child: const Icon(Icons.storefront),
            ),
            label: l10n.navStore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.insights_outlined),
            activeIcon: const Icon(Icons.insights),
            label: l10n.navAnalytics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
