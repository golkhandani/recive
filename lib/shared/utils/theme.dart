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
  final AppThemePalette palette;
  final TextStyle style;
  const AppTextTheme({
    required this.palette,
    required this.style,
  });

  AppTextTheme copyWith({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return AppTextTheme(
      palette: palette,
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
