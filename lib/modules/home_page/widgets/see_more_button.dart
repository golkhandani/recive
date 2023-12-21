import 'package:flutter/material.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    required this.onTap,
    required this.constraints,
    this.color,
    this.text = "See More!",
  });

  final VoidCallback onTap;
  final BoxConstraints constraints;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: constraints,
        decoration: BoxDecoration(
          borderRadius: kSmallBorderRadius,
          color: color ?? context.colorScheme.secondaryContainer,
        ),
        child: Center(
          child: Text(
            text,
            style: context.textTheme.seeMoreBrn.onSecondaryContainer.style,
          ),
        ),
      ),
    );
  }
}
