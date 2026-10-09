import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../../../habits/providers/habit_provider.dart';
import '../../../workouts/providers/workout_provider.dart';
import '../../../store/providers/store_provider.dart';
import '../../../../core/widgets/section_header.dart';
import 'package:zenith_wellness/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showResetConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.resetData),
        content: Text(l10n.resetDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<HabitProvider>().resetToDefaults();
              context.read<StoreProvider>().clearCart();
              context.read<WorkoutProvider>().resetSession();
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.dataResetSuccess),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final settings = context.watch<SettingsProvider>();
    final cardColor = theme.cardTheme.color ?? theme.cardColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Preference Card
          SectionHeader(title: l10n.preferences),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: Color(0xFF10B981)),
                  title: Text(l10n.language, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    settings.locale.languageCode == 'en' ? l10n.english : l10n.french,
                  ),
                  trailing: SegmentedButton<String>(
                    segments: [
                      ButtonSegment(value: 'en', label: Text(l10n.english)),
                      ButtonSegment(value: 'fr', label: Text(l10n.french)),
                    ],
                    selected: {settings.locale.languageCode},
                    onSelectionChanged: (val) {
                      settings.setLocale(Locale(val.first));
                    },
                  ),
                ),
                const Divider(height: 1),
                // Theme Mode Selector
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.palette_outlined, color: Color(0xFF6366F1)),
                          const SizedBox(width: 12),
                          Text(
                            l10n.themeMode,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment(
                            value: ThemeMode.system,
                            label: Text(l10n.themeSystem),
                            icon: const Icon(Icons.brightness_auto, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.light,
                            label: Text(l10n.themeLight),
                            icon: const Icon(Icons.light_mode, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text(l10n.themeDark),
                            icon: const Icon(Icons.dark_mode, size: 16),
                          ),
                        ],
                        selected: {settings.themeMode},
                        onSelectionChanged: (val) {
                          settings.setThemeMode(val.first);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Accessibility Card
          SectionHeader(title: l10n.accessibility),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.contrast, color: Color(0xFFF59E0B)),
                  title: Text(
                    l10n.highContrast,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Enhance borders and text clarity for WCAG compliance'),
                  value: settings.isHighContrast,
                  onChanged: (val) => settings.setHighContrast(val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.motion_photos_off, color: Color(0xFF8B5CF6)),
                  title: Text(
                    l10n.reduceAnimations,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Minimize motion transitions for reduced visual strain'),
                  value: settings.reduceAnimations,
                  onChanged: (val) => settings.setReduceAnimations(val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Data Management Card
          SectionHeader(title: l10n.account),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.restore, color: Colors.red),
              title: Text(
                l10n.resetData,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              subtitle: const Text('Restore sample habits, activity, and clear cart'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showResetConfirmation(context),
            ),
          ),
          const SizedBox(height: 24),
          // About
          Center(
            child: Column(
              children: [
                Text(
                  l10n.appVersion,
                  style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.developedBy,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
