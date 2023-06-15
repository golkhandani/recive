import 'package:flutter/material.dart';

extension UiBreakPointDetection on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  Size get size => MediaQuery.of(this).size;
  EdgeInsets get smallPadding => const EdgeInsets.all(8.0);

  double get vWidth => size.width;
  double get vHeight => size.height;
  bool get isNarrowWith => vWidth < (vHeight / 1.2);
  bool get isMediumWith => vWidth >= (vHeight / 1.2) && vWidth < vHeight * 1.8;
  bool get isWideWith => vWidth >= vHeight * 1.8 && vWidth < vHeight * 2.4;
  bool get isUltraWideWith => vWidth >= vHeight * 2.4;
}
