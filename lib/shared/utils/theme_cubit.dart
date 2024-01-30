import 'dart:async';

import 'package:hive/hive.dart';

import 'package:recive/shared/constants/key_constants.dart';
import 'package:recive/shared/extensions/color_themes_extentions.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

class ReciveThemeCubit extends MaybeEmitCubit<AppPaletteType> {
  static const themeStoreKey = StoreBoxConstant.themeStoreKey;
  static final defatulTheme = AppPaletteType.values.first;
  final Box<AppPaletteType> box;

  ReciveThemeCubit({
    required this.box,
    AppPaletteType? initalValue,
  }) : super(initalValue ?? defatulTheme) {
    unawaited(box.put(themeStoreKey, initalValue ?? defatulTheme));
  }

  void switchTheme(int index) async {
    final updatedTheme = AppPaletteType.values.firstWhere(
      (element) => element.index == index,
    );
    maybeEmit(updatedTheme);
    await box.put(themeStoreKey, updatedTheme);
  }
}
