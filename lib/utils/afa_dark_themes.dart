import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const light = Color(0xFF242423);
  static const semiLight = Color(0xFF333533);
  static const middle = Color(0xFFE6AD0F);
  static const semiDark = Color(0xFFF6F8F2);
  static const dark = Color(0xFFE8EDEB);
}

class SecondaryColors {
  static const light = Color(0xFF474747);
  static const semiLight = Color(0xFF666666);
  static const middle = Color(0xFFA5A5A5);
  static const semiDark = Color(0xFFCCCCCC);
  static const dark = Color(0xFFF2F2F2);
}

const darkTheme = MrzgThemePalette(
  brightness: Brightness.dark,
  primary: AppColors.middle,
  onPrimary: AppColors.dark,
  primaryContainer: AppColors.semiLight,
  onPrimaryContainer: AppColors.semiDark,
  secondary: SecondaryColors.light,
  onSecondary: SecondaryColors.dark,
  secondaryContainer: Color.fromARGB(255, 245, 165, 115),
  onSecondaryContainer: Color(0xff0f1d2a),
  tertiary: Color(0xff6a5779),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color.fromARGB(255, 255, 241, 218),
  onTertiaryContainer: Color(0xff241432),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: AppColors.light,
  onBackground: AppColors.dark,
  surface: AppColors.light,
  onSurface: AppColors.dark,
  surfaceVariant: Color(0xffdfe3eb),
  onSurfaceVariant: Color(0xff42474e),
  outline: Color(0xff73777f),
  outlineVariant: Color(0xffc2c7cf),
  shadow: Color.fromARGB(25, 0, 0, 0),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2f3033),
  onInverseSurface: Color(0xfff1f0f4),
  inversePrimary: Color(0xff9ccaff),
  surfaceTint: Color.fromARGB(0, 0, 0, 0),

  /// EXTRA

  cardBackground: Color.fromARGB(255, 235, 235, 235), // Off-white
  onCardBackground: Colors.black,

  chipBackground: Color(0xFF9E9E9E), // Gray
  onChipBackground: Colors.white,
  chipDisabledBackground: Color(0xFFBDBDBD), // Light gray
  onChipDisabledBackground: Colors.black87,

  success: Color(0xFF388E3C), // Dark green
  onSuccess: Colors.white,
  successContainer: Color(0xFFA5D6A7), // Light green
  onSuccessContainer: Colors.black,

  warning: Color(0xFFFF8F00), // Orange
  onWarning: Colors.black,
  warningContainer: Color(0xFFFFF59D), // Light yellow
  onWarningContainer: Colors.black,

  highlight: Color.fromARGB(255, 240, 227, 102), // Deep purple
  onHighlight: Colors.white,

  backBtnBackground: Color.fromARGB(255, 181, 196, 231), // Deep orange
  onBackBtnBackground: Color.fromARGB(255, 0, 0, 0),
  navBackground: AppColors.semiLight, // Brown
  onNavBackground: AppColors.semiDark,
  onNavUnselected: AppColors.semiDark, // Dark gray
  onNavSelected: AppColors.middle, // Deep orange

  tabBarSelected: Color(0xFFFFA000), // Amber
  onTabBarSelected: Colors.black,
  tabBarUnselected: Color(0xFFE0E0E0), // Light gray
  onTabBarUnselected: Colors.black87,

  textFieldBackground: Color(0xFF009688), // Teal
  onTextFieldBackground: Colors.white,
);
