import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

extension UiBreakPointDetection on BuildContext {
  // TextTheme get textTheme => Theme.of(this).textTheme;
  // ThemeData get theme => Theme.of(this);
  AppThemePalette get colorScheme => AppTheme.of(this).palette;
  Size get size => MediaQuery.sizeOf(this);
  EdgeInsets get smallPadding => const EdgeInsets.all(8.0);

  double get vWidth => size.width;
  double get vHeight => size.height;
  bool get isNarrowWith => vWidth < (vHeight / 1.2);
  bool get isMediumWith => vWidth >= (vHeight / 1.2) && vWidth < vHeight * 1.8;
  bool get isWideWith => vWidth >= vHeight * 1.8 && vWidth < vHeight * 2.4;
  bool get isUltraWideWith => vWidth >= vHeight * 2.4;

  double get viewTopPaddingHeight => MediaQuery.of(this).padding.top == 0
      ? 12
      : MediaQuery.of(this).padding.top;
  double get viewBottomPaddingHeight => MediaQuery.of(this).padding.bottom == 0
      ? 12
      : MediaQuery.of(this).padding.bottom;
  EdgeInsets get viewTopPadding => EdgeInsets.only(top: viewTopPaddingHeight);
  EdgeInsets get viewBottomPadding =>
      EdgeInsets.only(bottom: viewBottomPaddingHeight);

  double get footerHeight => 88;
  double get invisibleHeight =>
      footerHeight +
      viewBottomPaddingHeight +
      headerHeight +
      MediaQuery.of(this).padding.top;

  Color get randomColor => Color((Random().nextDouble() * 0xFFFF).toInt())
      .withOpacity(1.0)
      .withAlpha(255);

  Widget? checkLoadingState(LoadingState loadingState) {
    if (loadingState == LoadingState.none ||
        loadingState == LoadingState.loading) {
      return kSliverFillAnimatedLoading;
    }

    if (loadingState == LoadingState.error) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FluentIcons.error_circle_12_regular,
                color: Colors.redAccent,
                size: 12,
              ),
              SizedBox(width: 12),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return null;
  }
}

extension UiConstantsExtention on BuildContext {
  double get headerHeight => 48;
}
