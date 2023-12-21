import 'package:flutter/material.dart';

import 'package:recive/shared/utils/theme.dart';
import 'package:recive/shared/utils/theme_cubit.dart';

extension ReciveThemeColorScheme on ReciveTheme {
  ColorScheme get scheme {
    switch (this) {
      case ReciveTheme.dark:
        return colorScheme;
      default:
        return peeyadeScheme;
    }
  }
}
