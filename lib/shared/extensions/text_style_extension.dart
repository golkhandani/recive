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

extension AppTextColor on AppTextTheme {
  AppTextTheme withColor(Color color) => copyWith(color: color);

  /// COLORS
  AppTextTheme get primary => copyWith(color: _palette.primary);
  AppTextTheme get onPrimary => copyWith(color: _palette.onPrimary);
  AppTextTheme get primaryContainer =>
      copyWith(color: _palette.primaryContainer);
  AppTextTheme get onPrimaryContainer =>
      copyWith(color: _palette.onPrimaryContainer);
  AppTextTheme get secondary => copyWith(color: _palette.secondary);
  AppTextTheme get onSecondary => copyWith(color: _palette.onSecondary);
  AppTextTheme get secondaryContainer =>
      copyWith(color: _palette.secondaryContainer);
  AppTextTheme get onSecondaryContainer =>
      copyWith(color: _palette.onSecondaryContainer);
  AppTextTheme get tertiary => copyWith(color: _palette.tertiary);
  AppTextTheme get onTertiary => copyWith(color: _palette.onTertiary);
  AppTextTheme get tertiaryContainer =>
      copyWith(color: _palette.tertiaryContainer);
  AppTextTheme get onTertiaryContainer =>
      copyWith(color: _palette.onTertiaryContainer);
  AppTextTheme get error => copyWith(color: _palette.error);
  AppTextTheme get onError => copyWith(color: _palette.onError);
  AppTextTheme get errorContainer => copyWith(color: _palette.errorContainer);
  AppTextTheme get onErrorContainer =>
      copyWith(color: _palette.onErrorContainer);
  AppTextTheme get success => copyWith(color: _palette.success);
  AppTextTheme get onSuccess => copyWith(color: _palette.onSuccess);
  AppTextTheme get successContainer =>
      copyWith(color: _palette.successContainer);
  AppTextTheme get onSuccessContainer =>
      copyWith(color: _palette.onSuccessContainer);
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
}

extension AppTextSizer on AppTextTheme {
  AppTextTheme get headerLarge => copyWith(fontSize: 32);
  AppTextTheme get header2 => copyWith(fontSize: 28);
  AppTextTheme get header3 => copyWith(fontSize: 26);

  AppTextTheme get title1 => copyWith(fontSize: 30);
  AppTextTheme get title2 => copyWith(fontSize: 24);
  AppTextTheme get title3 => copyWith(fontSize: 20);
  AppTextTheme get titleMedium => copyWith(fontSize: 24);
  AppTextTheme get titleSmall => copyWith(fontSize: 20);
  AppTextTheme get titleTiny => copyWith(fontSize: 16);

  AppTextTheme get subtitleLarge => copyWith(fontSize: 18);
  AppTextTheme get subtitleSmall => copyWith(fontSize: 14);
  AppTextTheme get subtitleTiny => copyWith(fontSize: 12);
  AppTextTheme get subtitle2 => copyWith(fontSize: 16);
  AppTextTheme get subtitle3 => copyWith(fontSize: 14);

  AppTextTheme get body1 => copyWith(fontSize: 14);
  AppTextTheme get body2 => copyWith(fontSize: 12);

  AppTextTheme get seeMoreBrn => copyWith(fontSize: 16);

  AppTextTheme get hint => copyWith(fontSize: 12);
  AppTextTheme get label => copyWith(fontSize: 12);
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

extension AppTextTheme2 on BuildContext {
  TextStyle get textStyle => const TextStyle();
  AppTextTheme get textTheme => AppTheme.of(this).textTheme;
}

extension AAA on TextTheme {
  TextStyle get base => const TextStyle();
}

extension AppTextStyleSize on TextStyle {
  TextStyle get header => copyWith(fontSize: 32);
  TextStyle get title => copyWith(fontSize: 28);
  TextStyle get subtitle => copyWith(fontSize: 20);
  TextStyle get normal => copyWith(fontSize: 16);
  TextStyle get small => copyWith(fontSize: 14);
  TextStyle get tiny => copyWith(fontSize: 12);

  TextStyle get header1 => copyWith(fontSize: 32);
  TextStyle get header2 => copyWith(fontSize: 28);
  TextStyle get header3 => copyWith(fontSize: 26);

  TextStyle get title1 => copyWith(fontSize: 30);
  TextStyle get title2 => copyWith(fontSize: 24);
  TextStyle get title3 => copyWith(fontSize: 20);

  TextStyle get subtitle1 => copyWith(fontSize: 18);
  TextStyle get subtitle2 => copyWith(fontSize: 16);
  TextStyle get subtitle3 => copyWith(fontSize: 14);

  TextStyle get body1 => copyWith(fontSize: 14);
  TextStyle get body2 => copyWith(fontSize: 12);

  TextStyle get hint => copyWith(fontSize: 12);
  TextStyle get label => copyWith(fontSize: 12);
}

extension AppTextStyleColor on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
}
