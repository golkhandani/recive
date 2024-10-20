import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({
    super.key,
    required this.backgroundColor,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: kTinyPadding,
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
