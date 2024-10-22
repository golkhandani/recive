import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

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
            padding: kTinyPadding,
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
            ),
            child: Text(
              tag,
              style: context.typographyTheme.bodyMedium.onChipBackground.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
