import 'package:flutter/material.dart';

import 'package:recive/shared/extensions/context_ui_extension.dart';

extension TextStyleContext on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  TextStyle get titleLargeOnPrimaryContainer => textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  TextStyle get titleMediumOnPrimaryContainer =>
      textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  TextStyle get titleSmallOnPrimaryContainer => textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  TextStyle get titleLargePrimaryContainer => textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );

  TextStyle get titleLargeOnBackground => textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onBackground,
      );
  TextStyle get labelLargeOnPrimaryContainer => textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );

  TextStyle get labelLargeOnBackground => textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onBackground,
      );
  TextStyle get labelSmallOnPrimaryContainer => textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
}
