import 'package:flutter/material.dart';

class AppThemePalette {
  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color background;
  final Color onBackground;
  final Color highlight;
  final Color onHighlight;
  final Color surface;
  final Color onSurface;
  final Color shadow;
  final Color navBackground;
  final Color onNavBackground;
  final Color onNavSelected;
  final Color onNavUnselected;
  final Color textFieldBackground;
  final Color onTextFieldBackground;
  final Color tabBarSelected;
  final Color onTabBarSelected;
  final Color tabBarUnselected;
  final Color onTabBarUnselected;
  final Color chipDisabledBackground;
  final Color onChipDisabledBackground;
  final Color chipBackground;
  final Color onChipBackground;

  final Color cardBackground;
  final Color onCardBackground;

  final Color backBtnBackground;
  final Color onBackBtnBackground;

  AppThemePalette({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.highlight,
    required this.onHighlight,
    required this.shadow,
    required this.navBackground,
    required this.onNavBackground,
    required this.onNavSelected,
    required this.onNavUnselected,
    required this.textFieldBackground,
    required this.onTextFieldBackground,
    required this.tabBarSelected,
    required this.onTabBarSelected,
    required this.tabBarUnselected,
    required this.onTabBarUnselected,
    required this.chipDisabledBackground,
    required this.onChipDisabledBackground,
    required this.chipBackground,
    required this.onChipBackground,
    required this.cardBackground,
    required this.onCardBackground,
    required this.backBtnBackground,
    required this.onBackBtnBackground,
  });
}

class AppTextTheme {
  final AppThemePalette _palette;
  final TextStyle style;
  const AppTextTheme({
    required AppThemePalette palette,
    required this.style,
  }) : _palette = palette;

  AppTextTheme copyWith({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return AppTextTheme(
      palette: _palette,
      style: style.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class AppTheme extends InheritedWidget {
  AppTheme({
    super.key,
    required super.child,
    required this.palette,
  }) : textTheme = AppTextTheme(
          palette: palette,
          style: const TextStyle(),
        );

  final AppThemePalette palette;
  final AppTextTheme textTheme;

  static AppTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => palette != oldWidget.palette;
}

/// EXTENSIONS

extension AppThemeExtentions on BuildContext {
  AppThemePalette get colorTheme => AppTheme.of(this).palette;
  AppTextTheme get textTheme => AppTheme.of(this).textTheme;
}

extension AppTextStyleColor on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}

extension AppTextColor on AppTextTheme {
  AppTextTheme withColor(Color color) => copyWith(color: color);

  /// COLORS
  AppTextTheme get primary => copyWith(color: _palette.primary);
  AppTextTheme get onPrimary => copyWith(color: _palette.onPrimary);
  AppTextTheme get primaryContainer => copyWith(color: _palette.primaryContainer);
  AppTextTheme get onPrimaryContainer => copyWith(color: _palette.onPrimaryContainer);
  AppTextTheme get secondary => copyWith(color: _palette.secondary);
  AppTextTheme get onSecondary => copyWith(color: _palette.onSecondary);
  AppTextTheme get secondaryContainer => copyWith(color: _palette.secondaryContainer);
  AppTextTheme get onSecondaryContainer => copyWith(color: _palette.onSecondaryContainer);
  AppTextTheme get tertiary => copyWith(color: _palette.tertiary);
  AppTextTheme get onTertiary => copyWith(color: _palette.onTertiary);
  AppTextTheme get tertiaryContainer => copyWith(color: _palette.tertiaryContainer);
  AppTextTheme get onTertiaryContainer => copyWith(color: _palette.onTertiaryContainer);
  AppTextTheme get error => copyWith(color: _palette.error);
  AppTextTheme get onError => copyWith(color: _palette.onError);
  AppTextTheme get errorContainer => copyWith(color: _palette.errorContainer);
  AppTextTheme get onErrorContainer => copyWith(color: _palette.onErrorContainer);
  AppTextTheme get success => copyWith(color: _palette.success);
  AppTextTheme get onSuccess => copyWith(color: _palette.onSuccess);
  AppTextTheme get successContainer => copyWith(color: _palette.successContainer);
  AppTextTheme get onSuccessContainer => copyWith(color: _palette.onSuccessContainer);
  AppTextTheme get background => copyWith(color: _palette.background);
  AppTextTheme get onBackground => copyWith(color: _palette.onBackground);
  AppTextTheme get surface => copyWith(color: _palette.surface);
  AppTextTheme get onSurface => copyWith(color: _palette.onSurface);
  AppTextTheme get highlight => copyWith(color: _palette.highlight);
  AppTextTheme get onHighlight => copyWith(color: _palette.onHighlight);
  AppTextTheme get shadow => copyWith(color: _palette.shadow);

  AppTextTheme get onNavBackground => copyWith(color: _palette.onNavBackground);
  AppTextTheme get navBackground => copyWith(color: _palette.navBackground);
  AppTextTheme get onNavSelected => copyWith(color: _palette.onNavSelected);
  AppTextTheme get onNavUnselected => copyWith(color: _palette.onNavUnselected);

  AppTextTheme get cardBackground => copyWith(color: _palette.cardBackground);
  AppTextTheme get onCardBackground => copyWith(color: _palette.onCardBackground);

  AppTextTheme get chipBackground => copyWith(color: _palette.chipBackground);
  AppTextTheme get onChipBackground => copyWith(color: _palette.onChipBackground);
  AppTextTheme get onTextFieldBackground => copyWith(color: _palette.onTextFieldBackground);
  AppTextTheme get textFieldBackground => copyWith(color: _palette.textFieldBackground);
  AppTextTheme get chipDisabledBackground => copyWith(color: _palette.chipDisabledBackground);
  AppTextTheme get onChipDisabledBackground => copyWith(color: _palette.onChipDisabledBackground);
}

extension AppTextSizer on AppTextTheme {
  AppTextTheme get headerLarge => copyWith(fontSize: 32);
  AppTextTheme get headerMedium => copyWith(fontSize: 28);
  AppTextTheme get headerSmall => copyWith(fontSize: 26);

  AppTextTheme get titleLarge => copyWith(fontSize: 22, fontWeight: FontWeight.w900);
  AppTextTheme get titleMedium => copyWith(fontSize: 20, fontWeight: FontWeight.w800);
  AppTextTheme get titleSmall => copyWith(fontSize: 18, fontWeight: FontWeight.w700);
  AppTextTheme get titleTiny => copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  AppTextTheme get subtitleLarge => copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  AppTextTheme get subtitleMedium => copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  AppTextTheme get subtitleSmall => copyWith(fontSize: 12, fontWeight: FontWeight.w500);
  AppTextTheme get subtitleTiny => copyWith(fontSize: 10, fontWeight: FontWeight.w400);

  AppTextTheme get bodyMedium => copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  AppTextTheme get bodySmall => copyWith(fontSize: 12, fontWeight: FontWeight.w300);

  AppTextTheme get seeMore => copyWith(fontSize: 16, fontWeight: FontWeight.w800);

  AppTextTheme get hint => copyWith(fontSize: 12);
  AppTextTheme get label => copyWith(fontSize: 12);
}

// -------------------------- THEMES --------------------------
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

  navBackground: const Color.fromARGB(255, 122, 146, 225),
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
  navBackground: const Color.fromARGB(255, 255, 155, 6),
  onNavBackground: const Color.fromARGB(255, 255, 255, 255),
  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
  onNavSelected: const Color.fromARGB(255, 255, 255, 255),

  tabBarSelected: const Color.fromARGB(255, 255, 176, 29),
  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
  tabBarUnselected: const Color.fromARGB(255, 255, 227, 178),
  onTabBarUnselected: const Color.fromARGB(255, 105, 105, 105),

  textFieldBackground: const Color.fromARGB(255, 254, 171, 18),
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
  navBackground: const Color.fromARGB(255, 86, 176, 158),
  onNavBackground: const Color.fromARGB(255, 0, 0, 0),
  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
  onNavSelected: const Color.fromARGB(255, 255, 255, 255),

  tabBarSelected: const Color.fromARGB(255, 20, 167, 138),
  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
  tabBarUnselected: const Color.fromARGB(255, 171, 221, 216),
  onTabBarUnselected: const Color.fromARGB(255, 105, 105, 105),

  textFieldBackground: const Color.fromARGB(255, 67, 106, 96),
  onTextFieldBackground: const Color.fromARGB(255, 0, 0, 0),
);
