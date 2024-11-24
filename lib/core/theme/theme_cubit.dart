import 'dart:async';
import 'dart:ui';

import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/theme/mrzg_theme_palette.dart';
import 'package:art_for_all/utils/afa_dark_themes.dart';
import 'package:flutter/scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../utils/afa_light_themes.dart';

enum ThemeCubitState { blue, dark, light, system }

extension ThemeColorScheme on ThemeCubitState {
  MrzgThemePalette get colorPalette {
    if (this == ThemeCubitState.system) {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark ? darkTheme : trendyTheme;
    }
    switch (this) {
      case ThemeCubitState.blue:
      case ThemeCubitState.dark:
        return darkTheme;
      case ThemeCubitState.light:
      default:
        return trendyTheme;
    }
  }
}

class ThemeCubit extends Cubit<ThemeCubitState> {
  static const themeStoreKey = 'theme_state';
  static const defaultTheme = ThemeCubitState.light;
  final ISharedStorage sharedStorage;

  ThemeCubit({
    required this.sharedStorage,
    ThemeCubitState? initialValue,
  }) : super(initialValue ?? defaultTheme) {
    unawaited(
      sharedStorage.write(
        key: themeStoreKey,
        value: (initialValue ?? defaultTheme).name,
      ),
    );
  }

  void switchTheme(ThemeCubitState updatedTheme) async {
    emit(updatedTheme);
    await sharedStorage.write(
      key: themeStoreKey,
      value: updatedTheme.name,
    );
  }
}
