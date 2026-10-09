import 'package:flutter/material.dart';

class AccessibilityUtils {
  /// Wraps a button widget with accessible semantics
  static Widget accessibleButton({
    required Widget child,
    required String label,
    String? hint,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      enabled: enabled,
      child: child,
    );
  }

  /// Wraps an informative card or stat with header semantics
  static Widget accessibleHeader({
    required Widget child,
    required String label,
  }) {
    return Semantics(
      header: true,
      label: label,
      child: child,
    );
  }

  /// Wraps toggleable elements (like habit check or theme switch)
  static Widget accessibleToggle({
    required Widget child,
    required String label,
    required bool isToggled,
    String? hint,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      toggled: isToggled,
      child: child,
    );
  }
}
