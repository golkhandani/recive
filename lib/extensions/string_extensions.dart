import 'package:flutter/material.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension UiConstantsExtention on BuildContext {
  double get headerHeight => 48;
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
}
