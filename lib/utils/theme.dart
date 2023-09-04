import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recive/layout/context_ui_extension.dart';

const MaterialColor swatch = Colors.purple;

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
  brightness: Brightness.dark,
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

  // keep the same as surface
  background: primary.darken(0.7),
  onBackground: lightText,
  surface: primary.darken(0.7),
  onSurface: lightText,
  inverseSurface: primary.lighten(),
  onInverseSurface: darkText,
  shadow: primaryShadow,
);

const Color primaryLight = Color(0xFFA8DADC);
const Color primaryShadowLight = Color(0xFF348183);

const Color secondaryLight = Color(0xFF0C1B31);
const Color secondaryShadowLight = Color(0xFF0E131B);

const Color splashLight = Color.fromARGB(255, 207, 242, 236);
const Color splashShadowLight = Color.fromARGB(255, 78, 192, 196);

const Color errorLight = Color(0xFFE63946);
const Color errorShadowLight = Color(0xFFA62630);

const Color successLight = Color(0xFF55B587);
const Color successShadowLight = Color(0xFF317254);

const Color backgroundDarkLight = Color(0xFF071005);
const Color backgroundLightLight = Color(0xFFF1FAEE);
final ColorScheme colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  //
  primary: primaryLight,
  onPrimary: lightText,
  primaryContainer: primaryShadowLight,
  onPrimaryContainer: lightText,
  //
  secondary: secondaryLight,
  onSecondary: darkText,
  secondaryContainer: secondaryShadowLight,
  onSecondaryContainer: lightText,
  //
  tertiary: splashLight,
  onTertiary: darkText,
  tertiaryContainer: splashShadowLight,
  onTertiaryContainer: darkText,

  //
  error: errorLight,
  onError: darkText,
  errorContainer: errorShadowLight,
  onErrorContainer: darkText,

  // keep the same as surface
  background: primaryLight.lighten(0.7),
  onBackground: darkText,
  surface: primaryLight.lighten(0.7),
  onSurface: darkText,
  inverseSurface: primaryLight.darken(),
  onInverseSurface: darkText,
  shadow: primaryShadowLight,
);

TextTheme getTextTheme(ColorScheme colorScheme) {
  return GoogleFonts.spaceGroteskTextTheme().copyWith(
    displayMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.1,
      color: colorScheme.onSurface,
    ),
    bodyLarge: TextStyle(
      color: colorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      color: colorScheme.onSurface,
    ),
    bodySmall: TextStyle(
      color: colorScheme.onSurface,
    ),
    labelMedium: TextStyle(
      color: colorScheme.onSurface,
    ),
    headlineSmall: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    headlineLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
    ),
    titleLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
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
