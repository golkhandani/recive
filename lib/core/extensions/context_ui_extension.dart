import 'dart:math';

import 'package:flutter/material.dart';

extension UiBreakPointDetection on BuildContext {
  double get nTopSafeHeight => 48;
  double get contentHeight =>
      vHeight - vTopSafeHeight - nTopSafeHeight - vBottomSafeHeight - nTopSafeHeight;

  double get vTopSafeHeight =>
      MediaQuery.of(this).padding.top == 0 ? 12 : MediaQuery.of(this).padding.top;
  double get vBottomSafeHeight =>
      MediaQuery.of(this).padding.bottom == 0 ? 12 : MediaQuery.of(this).padding.bottom;
  //
  Size get size => MediaQuery.sizeOf(this);

  double get vWidth => size.width;
  double get vHeight => size.height;
  bool get isNarrowWith => vWidth < (vHeight / 1.2);
  bool get isMediumWith => vWidth >= (vHeight / 1.2) && vWidth < vHeight * 1.8;
  bool get isWideWith => vWidth >= vHeight * 1.8 && vWidth < vHeight * 2.4;
  bool get isUltraWideWith => vWidth >= vHeight * 2.4;

  double get viewTopPaddingHeight =>
      MediaQuery.of(this).padding.top == 0 ? 12 : MediaQuery.of(this).padding.top;
  double get viewBottomPaddingHeight =>
      MediaQuery.of(this).padding.bottom == 0 ? 12 : MediaQuery.of(this).padding.bottom;
  EdgeInsets get viewTopPadding => EdgeInsets.only(top: viewTopPaddingHeight);
  EdgeInsets get viewBottomPadding => EdgeInsets.only(bottom: viewBottomPaddingHeight);

  double get footerHeight => 88;
  double get headerHeight => 48;
  double get invisibleHeight =>
      footerHeight + viewBottomPaddingHeight + headerHeight + MediaQuery.of(this).padding.top;

  Color get randomColor =>
      Color((Random().nextDouble() * 0xFFFF).toInt()).withOpacity(1.0).withAlpha(255);
}
