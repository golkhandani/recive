import 'package:flutter/material.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class SettingDeleteAccount extends StatelessWidget {
  const SettingDeleteAccount({
    super.key,
    required this.isLoading,
    required this.onAccountDeleted,
  });

  final bool isLoading;
  final void Function() onAccountDeleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAccountDeleted,
      child: Container(
        padding: kTinyPadding,
        alignment: Alignment.center,
        constraints: const BoxConstraints.expand(height: 48),
        decoration: ShapeDecoration(
          color: context.colorTheme.errorContainer,
          shape: const StadiumBorder(
            side: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ))
            : Text(
                "Delete Account",
                textAlign: TextAlign.center,
                style: context.textTheme.titleTiny
                    .withColor(
                      context.colorTheme.onErrorContainer,
                    )
                    .style,
              ),
      ),
    );
  }
}
