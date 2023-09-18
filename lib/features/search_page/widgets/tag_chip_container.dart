import 'package:flutter/material.dart';

import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';

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
        borderRadius: BorderRadius.circular(8),
        color: context.theme.colorScheme.tertiary,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: context.theme.colorScheme.tertiaryContainer,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
  });

  final VoidCallback onTap;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: context.theme.colorScheme.tertiary,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: context.theme.colorScheme.tertiaryContainer,
          onTap: onTap,
          child: Container(
            padding: kMediumPadding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
