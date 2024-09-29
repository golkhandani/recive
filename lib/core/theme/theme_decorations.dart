import 'package:flutter/material.dart';

extension Decorations on ThemeData {
  InputDecoration get inputDecoration {
    return InputDecoration(
      iconColor: inputDecorationTheme.iconColor,
      labelStyle: inputDecorationTheme.labelStyle,
      floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
      helperStyle: inputDecorationTheme.helperStyle,
      helperMaxLines: inputDecorationTheme.helperMaxLines,
      hintStyle: inputDecorationTheme.hintStyle,
      hintFadeDuration: inputDecorationTheme.hintFadeDuration,
      errorStyle: inputDecorationTheme.errorStyle,
      errorMaxLines: inputDecorationTheme.errorMaxLines,
      floatingLabelBehavior: inputDecorationTheme.floatingLabelBehavior,
      floatingLabelAlignment: inputDecorationTheme.floatingLabelAlignment,
      isCollapsed: inputDecorationTheme.isCollapsed,
      isDense: inputDecorationTheme.isDense,
      contentPadding: inputDecorationTheme.contentPadding,
      prefixStyle: inputDecorationTheme.prefixStyle,
      prefixIconColor: inputDecorationTheme.prefixIconColor,
      suffixStyle: inputDecorationTheme.suffixStyle,
      suffixIconColor: inputDecorationTheme.suffixIconColor,
      counterStyle: inputDecorationTheme.counterStyle,
      filled: inputDecorationTheme.filled,
      fillColor: inputDecorationTheme.fillColor,
      focusColor: inputDecorationTheme.focusColor,
      hoverColor: inputDecorationTheme.hoverColor,
      errorBorder: inputDecorationTheme.errorBorder,
      focusedBorder: inputDecorationTheme.focusedBorder,
      focusedErrorBorder: inputDecorationTheme.focusedErrorBorder,
      disabledBorder: inputDecorationTheme.disabledBorder,
      enabledBorder: inputDecorationTheme.enabledBorder,
      border: inputDecorationTheme.border,
      alignLabelWithHint: inputDecorationTheme.alignLabelWithHint,
      constraints: inputDecorationTheme.constraints,
    );
  }
}
