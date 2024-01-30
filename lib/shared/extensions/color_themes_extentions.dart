// -------------------------- THEMES --------------------------
import 'package:flutter/material.dart';

import 'package:recive/shared/utils/theme.dart';

enum AppPaletteType {
  // dark,
  // light,
  blue,
  gold,
  pyd
}

extension ThemeColorScheme on AppPaletteType {
  AppThemePalette get colorPalette {
    switch (this) {
      case AppPaletteType.blue:
        return blueTheme;
      case AppPaletteType.gold:
        return goldTheme;
      case AppPaletteType.pyd:
        return pyd;
      default:
        return blueTheme;
    }
  }
}

final blueTheme = AppThemePalette(
  brightness: Brightness.light,

  primary: const Color.fromARGB(255, 147, 163, 255),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primaryContainer: const Color.fromARGB(255, 152, 169, 202),
  onPrimaryContainer: const Color.fromARGB(255, 0, 0, 0),

  secondary: const Color.fromARGB(255, 85, 112, 199),
  onSecondary: Colors.white,
  secondaryContainer: const Color.fromARGB(255, 5, 13, 112),
  onSecondaryContainer: const Color.fromARGB(255, 255, 255, 255),

  cardBackground: const Color.fromARGB(255, 85, 112, 199),
  onCardBackground: Colors.white,

  tertiary: const Color.fromARGB(255, 112, 142, 184),
  onTertiary: const Color.fromARGB(255, 0, 0, 0),
  tertiaryContainer: const Color.fromARGB(255, 152, 169, 207),
  onTertiaryContainer: const Color.fromRGBO(255, 255, 255, 1),

  chipBackground: const Color.fromARGB(255, 112, 142, 184),
  onChipBackground: const Color.fromARGB(255, 0, 0, 0),
  chipDisabledBackground: const Color.fromARGB(255, 152, 169, 207),
  onChipDisabledBackground: const Color.fromRGBO(255, 255, 255, 1),

  error: Colors.red,
  onError: Colors.white,
  errorContainer: const Color.fromRGBO(141, 8, 41, 1),
  onErrorContainer: Colors.white,

  success: Colors.green,
  onSuccess: Colors.white,
  successContainer: const Color.fromRGBO(8, 141, 10, 1),
  onSuccessContainer: Colors.white,

  background: const Color.fromARGB(255, 255, 255, 255), // Set to white
  onBackground: const Color.fromRGBO(0, 0, 0, 1),
  highlight: const Color.fromRGBO(0, 0, 0, 1),
  onHighlight: const Color.fromRGBO(255, 255, 255, 1),

  shadow: const Color.fromRGBO(124, 128, 155, 0.5),
  surface: const Color.fromRGBO(0, 0, 0, 1),
  onSurface: const Color.fromRGBO(255, 255, 255, 1),

  navBackground: const Color.fromARGB(255, 122, 146, 225).withOpacity(0.8),
  onNavBackground: const Color.fromARGB(255, 255, 255, 255),
  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
  onNavSelected: const Color.fromARGB(255, 255, 255, 255),
  backBtnBackground: const Color.fromARGB(255, 85, 112, 199),
  onBackBtnBackground: Colors.white,

  tabBarSelected: const Color.fromARGB(255, 5, 13, 112),
  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
  tabBarUnselected: const Color.fromARGB(255, 126, 145, 206),
  onTabBarUnselected: const Color.fromARGB(255, 0, 0, 0),

  textFieldBackground: const Color.fromARGB(255, 5, 13, 112),
  onTextFieldBackground: Colors.white,
);

final goldTheme = AppThemePalette(
  brightness: Brightness.light,

  primary: const Color.fromARGB(255, 255, 187, 0),
  onPrimary: const Color.fromARGB(255, 0, 0, 0),
  primaryContainer: const Color.fromARGB(255, 152, 169, 202),
  onPrimaryContainer: const Color.fromARGB(255, 0, 0, 0),

  secondary: const Color.fromARGB(255, 252, 229, 175),
  onSecondary: const Color.fromARGB(255, 0, 0, 0),
  secondaryContainer: const Color.fromARGB(255, 239, 170, 42),
  onSecondaryContainer: const Color.fromARGB(255, 0, 0, 0),

  cardBackground: const Color.fromARGB(255, 245, 230, 215),
  onCardBackground: const Color.fromARGB(255, 0, 0, 0),

  tertiary: const Color.fromARGB(255, 184, 112, 164),
  onTertiary: const Color.fromARGB(255, 0, 0, 0),
  tertiaryContainer: const Color.fromARGB(255, 255, 235, 183),
  onTertiaryContainer: const Color.fromARGB(255, 0, 0, 0),

  chipBackground: const Color.fromARGB(255, 250, 215, 133),
  onChipBackground: const Color.fromARGB(255, 0, 0, 0),
  chipDisabledBackground: const Color.fromARGB(255, 251, 237, 200),
  onChipDisabledBackground: const Color.fromARGB(255, 122, 121, 121),

  error: Colors.red,
  onError: Colors.white,
  errorContainer: const Color.fromRGBO(141, 8, 41, 1),
  onErrorContainer: Colors.white,

  success: Colors.green,
  onSuccess: Colors.white,
  successContainer: const Color.fromRGBO(8, 141, 10, 1),
  onSuccessContainer: Colors.white,

  background: const Color.fromARGB(255, 249, 246, 241), // Set to white
  onBackground: const Color.fromRGBO(0, 0, 0, 1),
  highlight: const Color.fromRGBO(0, 0, 0, 1),
  onHighlight: const Color.fromRGBO(255, 255, 255, 1),

  shadow: const Color.fromRGBO(124, 128, 155, 0.5),
  surface: const Color.fromRGBO(0, 0, 0, 1),
  onSurface: const Color.fromRGBO(255, 255, 255, 1),

  backBtnBackground: const Color.fromARGB(255, 209, 126, 2),
  onBackBtnBackground: const Color.fromARGB(255, 255, 255, 255),
  navBackground: const Color.fromARGB(255, 255, 155, 6).withOpacity(0.8),
  onNavBackground: const Color.fromARGB(255, 255, 255, 255),
  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
  onNavSelected: const Color.fromARGB(255, 255, 255, 255),

  tabBarSelected: const Color.fromARGB(255, 255, 176, 29),
  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
  tabBarUnselected: const Color.fromARGB(255, 255, 227, 178),
  onTabBarUnselected: const Color.fromARGB(255, 105, 105, 105),

  textFieldBackground: const Color.fromARGB(255, 240, 158, 6),
  onTextFieldBackground: const Color.fromARGB(255, 0, 0, 0),
);

final pyd = AppThemePalette(
  brightness: Brightness.light,

  primary: const Color.fromARGB(255, 15, 163, 155),
  onPrimary: const Color.fromARGB(255, 0, 0, 0),
  primaryContainer: const Color.fromARGB(255, 152, 202, 194),
  onPrimaryContainer: const Color.fromARGB(255, 0, 0, 0),

  secondary: const Color.fromARGB(255, 175, 252, 229),
  onSecondary: const Color.fromARGB(255, 0, 0, 0),
  secondaryContainer: const Color.fromARGB(255, 33, 190, 162),
  onSecondaryContainer: const Color.fromARGB(255, 0, 0, 0),

  cardBackground: const Color.fromARGB(255, 215, 239, 245),
  onCardBackground: const Color.fromARGB(255, 0, 0, 0),

  tertiary: const Color.fromARGB(255, 112, 184, 171),
  onTertiary: const Color.fromARGB(255, 0, 0, 0),
  tertiaryContainer: const Color.fromARGB(255, 183, 255, 238),
  onTertiaryContainer: const Color.fromARGB(255, 0, 0, 0),

  chipBackground: const Color.fromARGB(255, 133, 250, 234),
  onChipBackground: const Color.fromARGB(255, 0, 0, 0),
  chipDisabledBackground: const Color.fromARGB(255, 200, 251, 248),
  onChipDisabledBackground: const Color.fromARGB(255, 122, 121, 121),

  error: Colors.red,
  onError: Colors.white,
  errorContainer: const Color.fromRGBO(141, 8, 41, 1),
  onErrorContainer: Colors.white,

  success: Colors.green,
  onSuccess: Colors.white,
  successContainer: const Color.fromRGBO(8, 141, 10, 1),
  onSuccessContainer: Colors.white,

  background: const Color.fromARGB(255, 241, 249, 249), // Set to white
  onBackground: const Color.fromRGBO(0, 0, 0, 1),
  highlight: const Color.fromRGBO(0, 0, 0, 1),
  onHighlight: const Color.fromRGBO(255, 255, 255, 1),

  shadow: const Color.fromRGBO(124, 128, 155, 0.5),
  surface: const Color.fromRGBO(0, 0, 0, 1),
  onSurface: const Color.fromRGBO(255, 255, 255, 1),

  backBtnBackground: const Color.fromARGB(255, 2, 209, 178),
  onBackBtnBackground: const Color.fromARGB(255, 255, 255, 255),
  navBackground: const Color.fromARGB(255, 86, 176, 158).withOpacity(0.8),
  onNavBackground: const Color.fromARGB(255, 0, 0, 0),
  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
  onNavSelected: const Color.fromARGB(255, 255, 255, 255),

  tabBarSelected: const Color.fromARGB(255, 20, 167, 138),
  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
  tabBarUnselected: const Color.fromARGB(255, 171, 221, 216),
  onTabBarUnselected: const Color.fromARGB(255, 105, 105, 105),

  textFieldBackground: const Color.fromARGB(255, 67, 106, 96),
  onTextFieldBackground: const Color.fromARGB(255, 255, 255, 255),
);
