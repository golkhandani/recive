import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recive/layout/context_ui_extension.dart';

const MaterialColor swatch = Colors.purple;
final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.dark,
  //
  primary: const Color.fromARGB(255, 105, 42, 154),
  onPrimary: Colors.white,
  primaryContainer: const Color.fromARGB(255, 190, 138, 232),
  onPrimaryContainer: Colors.black,
  //
  secondary: const Color.fromARGB(255, 161, 215, 227),
  onSecondary: Colors.black,
  secondaryContainer: const Color.fromARGB(255, 15, 45, 63),
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

final ColorScheme colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  //
  primary: const Color.fromARGB(255, 78, 196, 200),
  onPrimary: Colors.black,
  primaryContainer: const Color.fromARGB(255, 67, 142, 145),
  onPrimaryContainer: Colors.white,
  //
  secondary: const Color.fromARGB(255, 49, 84, 150),
  onSecondary: Colors.white,
  secondaryContainer: const Color.fromARGB(255, 12, 18, 56),
  onSecondaryContainer: Colors.white,
  //
  tertiary: const Color.fromARGB(255, 185, 226, 223),
  onTertiary: Colors.black,
  tertiaryContainer: const Color.fromARGB(255, 148, 212, 216),
  onTertiaryContainer: Colors.black,

  //
  error: Colors.red,
  onError: Colors.white,
  errorContainer: const Color.fromARGB(255, 179, 48, 39),
  onErrorContainer: Colors.white,

  // keep the same as surface
  background: const Color(0xFFA8DADC).lighten(0.2),
  onBackground: Colors.black,
  surface: const Color(0xFFA8DADC).lighten(0.1),
  onSurface: Colors.black,
  inverseSurface: const Color.fromARGB(255, 30, 39, 39),
  onInverseSurface: Colors.white,
  shadow: const Color.fromARGB(255, 30, 39, 39),
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

enum ThemeName { dark, light }

class UptimeTheme {
  final ThemeName name;
  final ThemeData themeData;

  UptimeTheme({
    required this.name,
    required this.themeData,
  });

  static const radius = Radius.circular(8);

  static final borderRadius = BorderRadius.circular(8);

  static const rightRadius = BorderRadius.only(
    topRight: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );
  static const leftRadius = BorderRadius.only(
    topLeft: Radius.circular(8),
    bottomLeft: Radius.circular(8),
  );

  factory UptimeTheme.light() => UptimeTheme(
        name: ThemeName.light,
        themeData: ultravioletTheme,
      );
  factory UptimeTheme.dark() => UptimeTheme(
        name: ThemeName.dark,
        themeData: ultravioletTheme,
      );
}
