import 'package:flutter/material.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

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
        color: context.colorTheme.chipBackground,
        child: InkWell(
          borderRadius: kSmallBorderRadius,
          splashColor: context.colorTheme.chipBackground,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
            ),
            child: Text(
              tag,
              style: context.textTheme.bodyMedium.onChipBackground.style,
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
    this.backgroundColor,
  });

  final VoidCallback onTap;
  final String tag;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        borderRadius: kSmallBorderRadius,
        color: backgroundColor ?? context.colorTheme.tertiary,
        child: InkWell(
          borderRadius: kSmallBorderRadius,
          splashColor: context.colorTheme.tertiaryContainer,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
            ),
            child: Center(
              child: Text(
                tag,
                style: context.textTheme.bodySmall
                    .withColor(
                      color ?? context.colorTheme.onTertiary,
                    )
                    .style,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
