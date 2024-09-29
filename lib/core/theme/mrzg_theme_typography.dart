import 'package:art_for_all/core/theme/mrzg_theme_palette.dart';
import 'package:flutter/material.dart';

class MrzgThemeTypography {
  final MrzgThemePalette _palette;
  final TextStyle textStyle;
  const MrzgThemeTypography({
    required MrzgThemePalette palette,
    required this.textStyle,
  }) : _palette = palette;

  MrzgThemePalette get palette => _palette;

  MrzgThemeTypography copyWith({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? decoration,
  }) {
    return MrzgThemeTypography(
      palette: _palette,
      textStyle: textStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: color,
      ),
    );
  }
}
