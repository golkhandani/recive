import 'package:flutter/material.dart';

class MrzgThemePalette extends ColorScheme {
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;

  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;

  final Color highlight;
  final Color onHighlight;

  final Color navBackground;
  final Color onNavBackground;
  final Color onNavSelected;
  final Color onNavUnselected;
  final Color textFieldBackground;
  final Color onTextFieldBackground;
  final Color tabBarSelected;
  final Color onTabBarSelected;
  final Color tabBarUnselected;
  final Color onTabBarUnselected;
  final Color chipDisabledBackground;
  final Color onChipDisabledBackground;
  final Color chipBackground;
  final Color onChipBackground;

  final Color cardBackground;
  final Color onCardBackground;

  final Color backBtnBackground;
  final Color onBackBtnBackground;

  @override
  Color get background => super.surface;
  @override
  Color get onBackground => super.onSurface;

  const MrzgThemePalette({
    required super.brightness,
    required super.primary,
    required super.onPrimary,
    required super.primaryContainer,
    required super.onPrimaryContainer,
    required super.secondary,
    required super.onSecondary,
    required super.secondaryContainer,
    required super.onSecondaryContainer,
    required super.tertiary,
    required super.onTertiary,
    required super.tertiaryContainer,
    required super.onTertiaryContainer,
    required super.error,
    required super.onError,
    required super.errorContainer,
    required super.onErrorContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required super.background,
    required super.onBackground,
    required super.surface,
    required super.onSurface,
    required this.highlight,
    required this.onHighlight,
    required super.shadow,
    required this.navBackground,
    required this.onNavBackground,
    required this.onNavSelected,
    required this.onNavUnselected,
    required this.textFieldBackground,
    required this.onTextFieldBackground,
    required this.tabBarSelected,
    required this.onTabBarSelected,
    required this.tabBarUnselected,
    required this.onTabBarUnselected,
    required this.chipDisabledBackground,
    required this.onChipDisabledBackground,
    required this.chipBackground,
    required this.onChipBackground,
    required this.cardBackground,
    required this.onCardBackground,
    required this.backBtnBackground,
    required this.onBackBtnBackground,
    required super.scrim,
    required super.inverseSurface,
    required super.onInverseSurface,
    required super.inversePrimary,
    required super.surfaceTint,
    required super.outlineVariant,
    required super.outline,
    required super.onSurfaceVariant,
    required super.surfaceVariant,
  });
}
