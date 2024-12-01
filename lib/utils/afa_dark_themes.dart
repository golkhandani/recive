import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const light = Color.fromARGB(255, 9, 9, 9);
  static const semiLight = Color.fromARGB(255, 27, 27, 27);
  static const middle = Color.fromARGB(255, 221, 130, 242);
  static const semiDark = Color.fromARGB(255, 248, 242, 248);
  static const dark = Color.fromARGB(255, 235, 232, 237);
}

class SecondaryColors {
  static const light = Color.fromARGB(255, 39, 37, 37);
  static const semiLight = Color(0xFF666666);
  static const middle = Color(0xFFA5A5A5);
  static const semiDark = Color(0xFFCCCCCC);
  static const dark = Color(0xFFF2F2F2);
}

final darkTheme = MrzgThemePalette(
  brightness: Brightness.dark,
  primary: AppColors.middle,
  onPrimary: AppColors.light,
  primaryContainer: AppColors.semiLight,
  onPrimaryContainer: AppColors.semiDark,
  secondary: SecondaryColors.light,
  onSecondary: SecondaryColors.dark,
  secondaryContainer: const Color.fromARGB(255, 245, 165, 115),
  onSecondaryContainer: const Color(0xff0f1d2a),
  tertiary: AppColors.middle.withOpacity(0.5),
  onTertiary: const Color(0xffffffff),
  tertiaryContainer: const Color.fromARGB(255, 255, 241, 218),
  onTertiaryContainer: const Color(0xff241432),
  error: const Color(0xffba1a1a),
  onError: const Color(0xffffffff),
  errorContainer: const Color(0xffffdad6),
  onErrorContainer: const Color(0xff410002),
  background: AppColors.light,
  onBackground: AppColors.dark,
  surface: AppColors.light,
  onSurface: AppColors.dark,
  surfaceVariant: const Color(0xffdfe3eb),
  onSurfaceVariant: const Color(0xff42474e),
  outline: const Color(0xff73777f),
  outlineVariant: const Color(0xffc2c7cf),
  shadow: const Color.fromARGB(25, 0, 0, 0),
  scrim: const Color(0xff000000),
  inverseSurface: const Color(0xff2f3033),
  onInverseSurface: const Color(0xfff1f0f4),
  inversePrimary: const Color(0xff9ccaff),
  surfaceTint: const Color.fromARGB(0, 0, 0, 0),

  /// EXTRA

  cardBackground: const Color.fromARGB(255, 235, 235, 235), // Off-white
  onCardBackground: Colors.black,

  chipBackground: const Color.fromARGB(255, 213, 213, 213), // Gray
  onChipBackground: const Color.fromARGB(255, 29, 29, 29),
  chipDisabledBackground: const Color(0xFFBDBDBD), // Light gray
  onChipDisabledBackground: Colors.black87,

  success: const Color(0xFF388E3C), // Dark green
  onSuccess: Colors.white,
  successContainer: const Color(0xFFA5D6A7), // Light green
  onSuccessContainer: Colors.black,

  warning: const Color(0xFFFF8F00), // Orange
  onWarning: Colors.black,
  warningContainer: const Color(0xFFFFF59D), // Light yellow
  onWarningContainer: Colors.black,

  highlight: const Color.fromARGB(255, 240, 227, 102), // Deep purple
  onHighlight: Colors.white,

  backBtnBackground: const Color.fromARGB(255, 181, 196, 231), // Deep orange
  onBackBtnBackground: const Color.fromARGB(255, 0, 0, 0),
  navBackground: AppColors.semiLight, // Brown
  onNavBackground: AppColors.semiDark,
  onNavUnselected: AppColors.semiDark, // Dark gray
  onNavSelected: AppColors.middle, // Deep orange

  tabBarSelected: const Color(0xFFFFA000), // Amber
  onTabBarSelected: Colors.black,
  tabBarUnselected: const Color(0xFFE0E0E0), // Light gray
  onTabBarUnselected: Colors.black87,

  textFieldBackground: const Color(0xFF009688), // Teal
  onTextFieldBackground: Colors.white,
);
