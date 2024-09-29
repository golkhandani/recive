import 'package:art_for_all/core/theme/mrzg_theme_palette.dart';
import 'package:art_for_all/core/theme/mrzg_theme_provider.dart';
import 'package:art_for_all/core/theme/mrzg_theme_typography.dart';
import 'package:flutter/material.dart';

extension MrzgTheme on BuildContext {
  MrzgThemeProvider get mrzgTheme => MrzgThemeProvider.of(this);
  MrzgThemeTypography get typographyTheme => MrzgThemeProvider.of(this).typography;
  MrzgThemePalette get colorTheme => MrzgThemeProvider.of(this).palette;
  ThemeData get themeData => MrzgThemeProvider.of(this).data;
}
