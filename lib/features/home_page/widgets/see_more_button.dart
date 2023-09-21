import 'package:flutter/material.dart';

import 'package:recive/layout/context_ui_extension.dart';

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
          borderRadius: BorderRadius.circular(8),
          color: color ?? context.theme.colorScheme.secondaryContainer,
        ),
        child: Center(
          child: Text(
            text,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
