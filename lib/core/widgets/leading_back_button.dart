import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({
    super.key,
    required this.backgroundColor,
    this.padding = kTinyPadding,
  });

  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: kMediumBorderRadius),
      child: BackButton(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(context.colorTheme.onPrimaryContainer),
          iconSize: const WidgetStatePropertyAll(kToolbarHeight / 3),
        ),
      ),
    );
  }
}
