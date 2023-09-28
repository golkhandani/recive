import 'package:flutter/material.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';

class TagChipContainer extends StatelessWidget {
  const TagChipContainer({
    super.key,
    required this.onTap,
    required this.tag,
  });

  final VoidCallback onTap;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        borderRadius: kSmallBorderRadius,
        color: context.theme.colorScheme.tertiary,
        child: InkWell(
          borderRadius: kSmallBorderRadius,
          splashColor: context.theme.colorScheme.tertiaryContainer,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
            ),
            child: Text(
              tag,
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterTagChipContainer extends StatelessWidget {
  const FilterTagChipContainer({
    super.key,
    required this.onTap,
    required this.tag,
    this.color,
  });

  final VoidCallback onTap;
  final String tag;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        borderRadius: kSmallBorderRadius,
        color: color ?? context.theme.colorScheme.tertiary,
        child: InkWell(
          borderRadius: kSmallBorderRadius,
          splashColor: context.theme.colorScheme.tertiaryContainer,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
            ),
            child: Center(
              child: Text(
                tag,
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
