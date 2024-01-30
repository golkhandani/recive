import 'package:flutter/material.dart';

import 'package:recive/shared/utils/theme.dart';

/// EXTENSIONS

extension AppThemeExtentions on BuildContext {
  AppThemePalette get colorTheme => AppTheme.of(this).palette;
  AppTextTheme get textTheme => AppTheme.of(this).textTheme;
}

extension AppTextStyleColor on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}

extension AppTextColor on AppTextTheme {
  AppTextTheme withColor(Color color) => copyWith(color: color);

  /// COLORS
  AppTextTheme get primary => copyWith(color: palette.primary);
  AppTextTheme get onPrimary => copyWith(color: palette.onPrimary);
  AppTextTheme get primaryContainer => copyWith(color: palette.primaryContainer);
  AppTextTheme get onPrimaryContainer => copyWith(color: palette.onPrimaryContainer);
  AppTextTheme get secondary => copyWith(color: palette.secondary);
  AppTextTheme get onSecondary => copyWith(color: palette.onSecondary);
  AppTextTheme get secondaryContainer => copyWith(color: palette.secondaryContainer);
  AppTextTheme get onSecondaryContainer => copyWith(color: palette.onSecondaryContainer);
  AppTextTheme get tertiary => copyWith(color: palette.tertiary);
  AppTextTheme get onTertiary => copyWith(color: palette.onTertiary);
  AppTextTheme get tertiaryContainer => copyWith(color: palette.tertiaryContainer);
  AppTextTheme get onTertiaryContainer => copyWith(color: palette.onTertiaryContainer);
  AppTextTheme get error => copyWith(color: palette.error);
  AppTextTheme get onError => copyWith(color: palette.onError);
  AppTextTheme get errorContainer => copyWith(color: palette.errorContainer);
  AppTextTheme get onErrorContainer => copyWith(color: palette.onErrorContainer);
  AppTextTheme get success => copyWith(color: palette.success);
  AppTextTheme get onSuccess => copyWith(color: palette.onSuccess);
  AppTextTheme get successContainer => copyWith(color: palette.successContainer);
  AppTextTheme get onSuccessContainer => copyWith(color: palette.onSuccessContainer);
  AppTextTheme get background => copyWith(color: palette.background);
  AppTextTheme get onBackground => copyWith(color: palette.onBackground);
  AppTextTheme get surface => copyWith(color: palette.surface);
  AppTextTheme get onSurface => copyWith(color: palette.onSurface);
  AppTextTheme get highlight => copyWith(color: palette.highlight);
  AppTextTheme get onHighlight => copyWith(color: palette.onHighlight);
  AppTextTheme get shadow => copyWith(color: palette.shadow);

  AppTextTheme get onNavBackground => copyWith(color: palette.onNavBackground);
  AppTextTheme get navBackground => copyWith(color: palette.navBackground);
  AppTextTheme get onNavSelected => copyWith(color: palette.onNavSelected);
  AppTextTheme get onNavUnselected => copyWith(color: palette.onNavUnselected);

  AppTextTheme get cardBackground => copyWith(color: palette.cardBackground);
  AppTextTheme get onCardBackground => copyWith(color: palette.onCardBackground);

  AppTextTheme get chipBackground => copyWith(color: palette.chipBackground);
  AppTextTheme get onChipBackground => copyWith(color: palette.onChipBackground);
  AppTextTheme get onTextFieldBackground => copyWith(color: palette.onTextFieldBackground);
  AppTextTheme get textFieldBackground => copyWith(color: palette.textFieldBackground);
  AppTextTheme get chipDisabledBackground => copyWith(color: palette.chipDisabledBackground);
  AppTextTheme get onChipDisabledBackground => copyWith(color: palette.onChipDisabledBackground);
}

extension AppTextSizer on AppTextTheme {
  AppTextTheme get headerLarge => copyWith(fontSize: 32);
  AppTextTheme get headerMedium => copyWith(fontSize: 28);
  AppTextTheme get headerSmall => copyWith(fontSize: 26);

  AppTextTheme get titleLarge => copyWith(fontSize: 22, fontWeight: FontWeight.w900);
  AppTextTheme get titleMedium => copyWith(fontSize: 20, fontWeight: FontWeight.w800);
  AppTextTheme get titleSmall => copyWith(fontSize: 18, fontWeight: FontWeight.w700);
  AppTextTheme get titleTiny => copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  AppTextTheme get subtitleLarge => copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  AppTextTheme get subtitleMedium => copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  AppTextTheme get subtitleSmall => copyWith(fontSize: 12, fontWeight: FontWeight.w500);
  AppTextTheme get subtitleTiny => copyWith(fontSize: 10, fontWeight: FontWeight.w400);

  AppTextTheme get bodyMedium => copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  AppTextTheme get bodySmall => copyWith(fontSize: 12, fontWeight: FontWeight.w300);

  AppTextTheme get seeMore => copyWith(fontSize: 16, fontWeight: FontWeight.w800);

  AppTextTheme get hint => copyWith(fontSize: 12);
  AppTextTheme get label => copyWith(fontSize: 12);
}
