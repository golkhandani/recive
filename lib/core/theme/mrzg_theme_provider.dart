import 'package:art_for_all/core/theme/theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class MrzgThemeProvider extends InheritedWidget {
  final MrzgThemePalette _palette;
  final MrzgThemeTypography _typography;
  const MrzgThemeProvider({
    super.key,
    required super.child,
    required MrzgThemePalette palette,
    required MrzgThemeTypography typography,
  })  : _palette = palette,
        _typography = typography;

  MrzgThemePalette get palette => _palette;
  MrzgThemeTypography get typography => _typography;
  ThemeData get _flex => FlexThemeData.light(
        scheme: FlexScheme.custom,
        colorScheme: palette,
        subThemesData: FlexSubThemesData(
          blendOnColors: true,
          blendTextTheme: true,
          useTextTheme: true,
          thinBorderWidth: 2.0,
          thickBorderWidth: 2.0,
          defaultRadius: 12.0,
          inputDecoratorSchemeColor: SchemeColor.surface,
          inputDecoratorFillColor: palette.onTextFieldBackground,
          inputDecoratorBorderSchemeColor: SchemeColor.primary,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.onPrimaryContainer,
          inputCursorSchemeColor: SchemeColor.onPrimaryContainer,
          inputSelectionSchemeColor: SchemeColor.primaryContainer,
          alignedDropdown: true,
          tooltipRadius: 4,
          tooltipSchemeColor: SchemeColor.inverseSurface,
          tooltipOpacity: 0.9,
          useInputDecoratorThemeInDialogs: true,
          snackBarElevation: 6,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          //
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailLabelType: NavigationRailLabelType.none,
          navigationBarElevation: 1,
          bottomAppBarSchemeColor: SchemeColor.primary,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        surfaceTint: Colors.transparent,
        swapLegacyOnMaterial3: true,
        fontFamily: typography.textStyle.fontFamily,
        appBarBackground: palette.primary,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      );
  ThemeData get data => _flex.copyWith(
        scaffoldBackgroundColor: palette.surface,
        bottomNavigationBarTheme: _flex.bottomNavigationBarTheme.copyWith(
          backgroundColor: palette.navBackground,
          selectedItemColor: palette.onNavSelected,
          selectedIconTheme: _flex.bottomNavigationBarTheme.selectedIconTheme!.copyWith(
            color: palette.onNavSelected,
          ),
          unselectedItemColor: palette.onNavUnselected,
          unselectedIconTheme: _flex.bottomNavigationBarTheme.selectedIconTheme!.copyWith(
            color: palette.onNavUnselected,
          ),
        ),
        appBarTheme: _flex.appBarTheme.copyWith(foregroundColor: palette.onPrimary),
        switchTheme: _flex.switchTheme.copyWith(
          thumbColor: WidgetStatePropertyAll(
            palette.primary,
          ),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return palette.chipDisabledBackground;
            } else {
              return palette.cardBackground;
            }
          }),
          trackOutlineColor: WidgetStatePropertyAll(
            palette.primary,
          ),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        progressIndicatorTheme: _flex.progressIndicatorTheme.copyWith(
          color: palette.primary,
        ),
        sliderTheme: _flex.sliderTheme.copyWith(
          thumbColor: palette.primary,
          activeTrackColor: palette.onPrimaryContainer,
          secondaryActiveTrackColor: palette.onSecondary,
          valueIndicatorColor: palette.onPrimaryContainer,
          valueIndicatorStrokeColor: palette.primaryContainer,
          valueIndicatorTextStyle:
              typography.hint.textStyle.copyWith(color: palette.primaryContainer),
        ),
        inputDecorationTheme: _flex.inputDecorationTheme.copyWith(
          contentPadding: const EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: palette.onPrimaryContainer,
              width: 2.0,
            ),
          ),
          fillColor: palette.primaryContainer,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: palette.tertiary,
              width: 2.0,
            ),
          ),
        ),
      );
  Brightness get brightness => palette.brightness;
  static MrzgThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MrzgThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
