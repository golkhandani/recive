import 'package:art_for_all/core/theme/mrzg_theme_typography.dart';
import 'package:flutter/material.dart';

extension TextStyleExtended on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}

extension ThemedText on MrzgThemeTypography {
  MrzgThemeTypography copyWithColor({required Color color}) => copyWith(
        color: color,
      );

  MrzgThemeTypography copyWithStyle({
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  /// COLORS
  MrzgThemeTypography get primary => copyWith(color: palette.primary);
  MrzgThemeTypography get primaryLink => subtitleMedium.copyWith(
        color: palette.primary,
        decoration: TextDecoration.underline,
      );
  MrzgThemeTypography get onPrimary => copyWithColor(color: palette.onPrimary);
  MrzgThemeTypography get primaryContainer => copyWithColor(color: palette.primaryContainer);

  MrzgThemeTypography get onPrimaryContainer =>
      copyWithColor(color: palette.onPrimaryContainer);
  MrzgThemeTypography get secondary => copyWithColor(color: palette.secondary);
  MrzgThemeTypography get secondaryLink => secondary.copyWith(
        decoration: TextDecoration.underline,
      );
  MrzgThemeTypography get onSecondary => copyWithColor(color: palette.onSecondary);

  MrzgThemeTypography get secondaryContainer =>
      copyWithColor(color: palette.secondaryContainer);
  MrzgThemeTypography get onSecondaryContainer =>
      copyWithColor(color: palette.onSecondaryContainer);
  MrzgThemeTypography get tertiary => copyWithColor(color: palette.tertiary);
  MrzgThemeTypography get onTertiary => copyWithColor(color: palette.onTertiary);
  MrzgThemeTypography get tertiaryContainer =>
      copyWithColor(color: palette.tertiaryContainer);
  MrzgThemeTypography get onTertiaryContainer =>
      copyWithColor(color: palette.onTertiaryContainer);
  MrzgThemeTypography get error => copyWithColor(color: palette.error);
  MrzgThemeTypography get onError => copyWithColor(color: palette.onError);
  MrzgThemeTypography get errorContainer => copyWithColor(color: palette.errorContainer);
  MrzgThemeTypography get onErrorContainer => copyWithColor(color: palette.onErrorContainer);
  MrzgThemeTypography get success => copyWithColor(color: palette.success);
  MrzgThemeTypography get onSuccess => copyWithColor(color: palette.onSuccess);
  MrzgThemeTypography get successContainer => copyWithColor(color: palette.successContainer);
  MrzgThemeTypography get onSuccessContainer =>
      copyWithColor(color: palette.onSuccessContainer);
  MrzgThemeTypography get background => copyWithColor(color: palette.background);
  MrzgThemeTypography get onBackground => copyWithColor(color: palette.onBackground);
  MrzgThemeTypography get surface => copyWithColor(color: palette.surface);
  MrzgThemeTypography get onSurface => copyWithColor(color: palette.onSurface);
  MrzgThemeTypography get highlight => copyWithColor(color: palette.highlight);
  MrzgThemeTypography get onHighlight => copyWithColor(color: palette.onHighlight);
  MrzgThemeTypography get shadow => copyWithColor(color: palette.shadow);

  MrzgThemeTypography get onNavBackground => copyWithColor(color: palette.onNavBackground);
  MrzgThemeTypography get navBackground => copyWithColor(color: palette.navBackground);
  MrzgThemeTypography get onNavSelected => copyWithColor(color: palette.onNavSelected);
  MrzgThemeTypography get onNavUnselected => copyWithColor(color: palette.onNavUnselected);

  MrzgThemeTypography get cardBackground => copyWithColor(color: palette.cardBackground);
  MrzgThemeTypography get onCardBackground => copyWithColor(color: palette.onCardBackground);

  MrzgThemeTypography get chipBackground => copyWithColor(color: palette.chipBackground);
  MrzgThemeTypography get onChipBackground => copyWithColor(color: palette.onChipBackground);
  MrzgThemeTypography get onTextFieldBackground =>
      copyWithColor(color: palette.onTextFieldBackground);
  MrzgThemeTypography get textFieldBackground =>
      copyWithColor(color: palette.textFieldBackground);
  MrzgThemeTypography get chipDisabledBackground =>
      copyWithColor(color: palette.chipDisabledBackground);
  MrzgThemeTypography get onChipDisabledBackground =>
      copyWithColor(color: palette.onChipDisabledBackground);

  // STYLES

  MrzgThemeTypography get headerLarge => copyWithStyle(
        fontSize: 2 * textStyle.fontSize!,
      );
  MrzgThemeTypography get headerMedium => copyWithStyle(
        fontSize: 1.8 * textStyle.fontSize!,
      );
  MrzgThemeTypography get headerSmall => copyWithStyle(
        fontSize: 1.6 * textStyle.fontSize!,
      );

  MrzgThemeTypography get titleLarge =>
      copyWithStyle(fontSize: 1.6 * textStyle.fontSize!, fontWeight: FontWeight.w900);
  MrzgThemeTypography get titleMedium =>
      copyWithStyle(fontSize: 1.4 * textStyle.fontSize!, fontWeight: FontWeight.w800);
  MrzgThemeTypography get titleSmall =>
      copyWithStyle(fontSize: 1.2 * textStyle.fontSize!, fontWeight: FontWeight.w700);
  MrzgThemeTypography get titleTiny =>
      copyWithStyle(fontSize: textStyle.fontSize!, fontWeight: FontWeight.w600);

  MrzgThemeTypography get subtitleLarge =>
      copyWithStyle(fontSize: textStyle.fontSize!, fontWeight: FontWeight.w700);
  MrzgThemeTypography get subtitleMedium =>
      copyWithStyle(fontSize: 0.8 * textStyle.fontSize!, fontWeight: FontWeight.w600);
  MrzgThemeTypography get subtitleSmall =>
      copyWithStyle(fontSize: 0.6 * textStyle.fontSize!, fontWeight: FontWeight.w500);
  MrzgThemeTypography get subtitleTiny =>
      copyWithStyle(fontSize: 0.4 * textStyle.fontSize!, fontWeight: FontWeight.w400);

  MrzgThemeTypography get bodyLarge =>
      copyWithStyle(fontSize: textStyle.fontSize!, fontWeight: FontWeight.w400);
  MrzgThemeTypography get bodyMedium =>
      copyWithStyle(fontSize: 0.8 * textStyle.fontSize!, fontWeight: FontWeight.w400);
  MrzgThemeTypography get bodySmall =>
      copyWithStyle(fontSize: 0.6 * textStyle.fontSize!, fontWeight: FontWeight.w300);

  MrzgThemeTypography get hint => copyWithStyle(fontSize: 0.6 * textStyle.fontSize!);
  MrzgThemeTypography get label => copyWithStyle(fontSize: 0.6 * textStyle.fontSize!);
  MrzgThemeTypography get caption => copyWithStyle(fontSize: 0.58 * textStyle.fontSize!);
}
