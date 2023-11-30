import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:recive/shared/extensions/color_extentions.dart';

enum ThemeName { dark, light }

const MaterialColor swatch = Colors.purple;

final ColorScheme peeyadeScheme = ColorScheme(
  brightness: Brightness.light,

  primary: Color.fromARGB(255, 45, 195, 198),
  onPrimary: const Color.fromARGB(255, 0, 0, 0),
  primaryContainer: Color.fromARGB(255, 152, 202, 202),
  onPrimaryContainer: const Color.fromARGB(255, 0, 0, 0),

  secondary: Color.fromARGB(255, 17, 71, 71),
  onSecondary: Colors.white,
  secondaryContainer: Color.fromRGBO(0, 0, 0, 1),
  onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),

  tertiary: Color.fromARGB(255, 150, 180, 180),
  onTertiary: Colors.white,
  tertiaryContainer: Color.fromARGB(255, 44, 88, 88),
  onTertiaryContainer: Color.fromRGBO(255, 255, 255, 1),

  error: Colors.red,
  onError: Colors.white,
  errorContainer: Color.fromRGBO(141, 8, 41, 1),
  onErrorContainer: Colors.white,

  background: Color.fromARGB(255, 228, 255, 255), // Set to white
  onBackground: Color.fromRGBO(0, 0, 0, 1),
  surface: Color.fromRGBO(0, 0, 0, 1),
  onSurface: Color.fromRGBO(255, 255, 255, 1),
  inverseSurface: Color.fromRGBO(124, 128, 155, 1),
  onInverseSurface: Color.fromRGBO(0, 0, 0, 1),
  shadow: Color.fromRGBO(124, 128, 155, 0.5),
);

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.dark,
  //
  primary: const Color.fromARGB(255, 105, 42, 154),
  onPrimary: Colors.white,
  primaryContainer: const Color.fromARGB(255, 190, 138, 232),
  onPrimaryContainer: Colors.black,
  //
  secondary: const Color.fromARGB(255, 12, 18, 56),
  onSecondary: Colors.white,
  secondaryContainer: const Color.fromARGB(255, 49, 84, 150),
  onSecondaryContainer: Colors.white,
  //
  tertiary: const Color.fromARGB(255, 124, 92, 149),
  onTertiary: Colors.white,
  tertiaryContainer: const Color.fromARGB(255, 42, 10, 65),
  onTertiaryContainer: Colors.white,

  //
  error: Colors.red,
  onError: Colors.white,
  errorContainer: const Color.fromARGB(255, 179, 48, 39),
  onErrorContainer: Colors.white,

  // keep the same as surface
  background: const Color.fromARGB(255, 105, 42, 154).darken(0.4),
  onBackground: Colors.white,
  surface: const Color.fromARGB(255, 105, 42, 154).darken(0.2),
  onSurface: Colors.white,
  inverseSurface: const Color.fromARGB(255, 105, 42, 154).lighten(0.3),
  onInverseSurface: Colors.white,
  shadow: const Color.fromARGB(255, 105, 42, 154),
);

final ColorScheme colorSchemeLight = peeyadeScheme ??
    ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(205, 155, 255, 1),
      onPrimary: Colors.white,
      primaryContainer: Color.fromRGBO(0, 0, 0, 1),
      onPrimaryContainer: Colors.white,

      secondary: Color.fromRGBO(0, 0, 0, 1),
      onSecondary: Colors.white,
      secondaryContainer: Color.fromRGBO(255, 255, 255, 1),
      onSecondaryContainer: const Color.fromARGB(255, 0, 0, 0),

      tertiary: Color.fromRGBO(0, 0, 0, 1),
      onTertiary: Colors.white,
      tertiaryContainer: Color.fromRGBO(0, 0, 0, 1),
      onTertiaryContainer: Color.fromRGBO(255, 255, 255, 1),

      error: Colors.red,
      onError: Colors.white,
      errorContainer: Color.fromRGBO(181, 177, 178, 0.8),
      onErrorContainer: Colors.white,

      background: Colors.white, // Set to white
      onBackground: Color.fromRGBO(0, 0, 0, 0.8),
      surface: Color.fromRGBO(0, 0, 0, 1),
      onSurface: Color.fromRGBO(255, 255, 255, 1),
      inverseSurface: Color.fromRGBO(124, 128, 155, 0.8),
      onInverseSurface: Color.fromRGBO(0, 0, 0, 0.8),
      shadow: Color.fromRGBO(124, 128, 155, 0.8),
    );

TextTheme getTextTheme(ColorScheme colorScheme) {
  return GoogleFonts.quicksandTextTheme().copyWith(
    displayMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      height: 1.5,
      color: colorScheme.onSurface,
    ),
    bodyLarge: TextStyle(
      height: 2,
      color: colorScheme.onSurface,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      height: 1.5,
      color: colorScheme.onSurface,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      height: 1.2,
      color: colorScheme.onSurface,
      fontSize: 12,
    ),
    labelMedium: TextStyle(
      height: 1.5,
      color: colorScheme.onSurface,
    ),
    headlineSmall: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      height: 1.2,
    ),
    headlineLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      height: 2,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      height: 1.2,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      height: 1.5,
    ),
    titleLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      height: 2,
    ),
  );
}

final ThemeData ultravioletTheme = ThemeData(
  colorScheme: colorScheme,
  primarySwatch: swatch,
  scaffoldBackgroundColor: colorScheme.surface,
  primaryColor: colorScheme.primary,
  splashColor: colorScheme.tertiary,
  highlightColor: Colors.transparent,
  canvasColor: colorScheme.surface,
  shadowColor: colorScheme.shadow,
  hintColor: colorScheme.tertiary,
  fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
  textTheme: getTextTheme(colorScheme),
  buttonTheme: ButtonThemeData(
    buttonColor: colorScheme.primary,
    textTheme: ButtonTextTheme.primary,
  ),
  cardTheme: CardTheme(
    color: colorScheme.secondary,
    elevation: 5.0,
  ),
  iconTheme: IconThemeData(color: colorScheme.onBackground),
  toggleButtonsTheme: const ToggleButtonsThemeData(
    fillColor: Color(0xFFF9A3B6),
    selectedColor: Color(0xFFF48FB1),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: colorScheme.primary,
      ),
    ),
    hintStyle: TextStyle(color: colorScheme.tertiary),
    labelStyle: TextStyle(color: colorScheme.primary),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: colorScheme.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: colorScheme.primary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: colorScheme.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: colorScheme.error),
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: colorScheme.primary,
    inactiveTrackColor: colorScheme.tertiary,
    // thumbColor: Color(0xFFD1EBBB),
    // overlayColor: Color(0xFF6DA872),
    // valueIndicatorColor: Color(0xFFF48FB1),
  ),
);
