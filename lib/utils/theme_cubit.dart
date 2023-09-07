import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:recive/utils/maybe_emit_cubit.dart';
import 'package:recive/utils/theme.dart';

enum ReciveTheme {
  dark,
  light,
}

extension ReciveThemeColorScheme on ReciveTheme {
  ColorScheme get scheme {
    switch (this) {
      case ReciveTheme.dark:
        return colorScheme;
      default:
        return colorSchemeLight;
    }
  }
}

class ReciveThemeCubit extends MaybeEmitCubit<ReciveTheme> {
  static const themeStoreKey = 'themeStoreKey';
  static const defatulTheme = ReciveTheme.dark;
  final Box<ReciveTheme> box;

  ReciveThemeCubit({
    required this.box,
    ReciveTheme? initalValue,
  }) : super(initalValue ?? defatulTheme) {
    unawaited(box.put(themeStoreKey, initalValue ?? defatulTheme));
  }

  void switchTheme(int index) async {
    final updatedTheme = ReciveTheme.values.firstWhere(
      (element) => element.index == index,
    );
    maybeEmit(updatedTheme);
    await box.put(themeStoreKey, updatedTheme);
  }
}
