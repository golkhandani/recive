import 'dart:async';

import 'package:hive/hive.dart';

import 'package:recive/shared/constants/key_constants.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

enum ReciveTheme {
  dark,
  light,
}

class ReciveThemeCubit extends MaybeEmitCubit<ReciveTheme> {
  static const themeStoreKey = StoreBoxConstant.themeStoreKey;
  static const defatulTheme = ReciveTheme.light;
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
