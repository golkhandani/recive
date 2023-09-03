import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recive/layout/context_ui_extension.dart';

const MaterialColor swatch = Colors.purple;
// const Color primary = Color(0xFFA8DADC);
// const Color primaryShadow = Color(0xFF348183);

// const Color secondary = Color(0xFF0C1B31);
// const Color secondaryShadow = Color(0xFF0E131B);

// const Color splash = Color(0xFFCDEAE5);
// const Color splashShadow = Color(0xFF348183);

// const Color error = Color(0xFFE63946);
// const Color errorShadow = Color(0xFFA62630);

// const Color success = Color(0xFF55B587);
// const Color successShadow = Color(0xFF317254);

// const Color backgroundDark = Color(0xFF071005);
// const Color backgroundLight = Color(0xFFF1FAEE);

const Color primary = Color.fromARGB(255, 237, 213, 255);
const Color primaryShadow = Color.fromARGB(255, 91, 8, 112);

const Color secondary = Color.fromARGB(255, 40, 43, 72);
const Color secondaryShadow = Color.fromARGB(255, 10, 69, 105);

const Color splash = Color.fromARGB(255, 203, 164, 232);
const Color splashShadow = Color.fromARGB(255, 25, 4, 41);

const Color error = Color(0xFFE63946);
const Color errorShadow = Color(0xFFA62630);

const Color success = Color(0xFF5DA27E);
const Color successShadow = Color(0xFF358B59);

const Color backgroundDark = Color(0xFF071005);
const Color backgroundLight = Color(0xFFF1FAEE);

const Color lightText = backgroundLight;
const Color darkText = backgroundDark;
const Color hint = primaryShadow;

final ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.light,
  //
  primary: primary,
  onPrimary: darkText,
  primaryContainer: primaryShadow,
  onPrimaryContainer: lightText,
  //
  secondary: secondary,
  onSecondary: lightText,
  secondaryContainer: secondaryShadow,
  onSecondaryContainer: lightText,
  //
  tertiary: splash,
  onTertiary: darkText,
  tertiaryContainer: splashShadow,
  onTertiaryContainer: lightText,

  //
  error: error,
  onError: lightText,
  errorContainer: errorShadow,
  onErrorContainer: lightText,
  //
  // outline: ,
  // outlineVariant: ,
  background: primary.lighten(0.06),
  onBackground: darkText,
  surface: backgroundLight,
  onSurface: darkText,
  // surfaceVariant: ,
  // onSurfaceVariant: ,
  // inverseSurface: ,
  // onInverseSurface: ,
  // inversePrimary: ,
  shadow: primaryShadow,

  // scrim: ,
  // surfaceTint: ,
);

final ThemeData ultravioletTheme = ThemeData(
  colorScheme: colorScheme,
  primarySwatch: swatch,
  scaffoldBackgroundColor: colorScheme.background,
  primaryColor: colorScheme.primary,
  splashColor: colorScheme.tertiary,
  highlightColor: Colors.transparent,
  canvasColor: colorScheme.surface,
  shadowColor: colorScheme.shadow,
  hintColor: colorScheme.tertiary,
  fontFamily: GoogleFonts.nunito().fontFamily,
  textTheme: TextTheme(
    displayMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: colorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      color: colorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      color: colorScheme.onBackground,
    ),
    bodySmall: TextStyle(
      color: colorScheme.onBackground,
    ),
    labelMedium: TextStyle(
      color: colorScheme.onBackground,
    ),
    headlineSmall: TextStyle(
      color: colorScheme.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    headlineLarge: TextStyle(
      color: colorScheme.onBackground,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onBackground,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleLarge: TextStyle(
      color: colorScheme.onBackground,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
  ),
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
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: primary,
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
