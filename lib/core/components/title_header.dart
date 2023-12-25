import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';

class TitleHeader extends HookWidget {
  const TitleHeader({
    super.key,
    this.title = '',
    this.titleColor,
    this.backgroundColor,
  });
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final hightlightColor = context.colorTheme.tertiary;
    final backgroundColorV = backgroundColor ?? context.colorTheme.tertiaryContainer;
    final titleColorV = titleColor ?? context.colorTheme.onPrimary;
    final backbtn = SizedBox(
      width: 32,
      height: 32,
      child: Icon(
        Icons.arrow_back,
        size: 24,
        color: context.colorTheme.onBackBtnBackground,
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12, top: 4),
      color: backgroundColorV,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (navigationService.canBack) ...[
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Material(
                  borderRadius: BorderRadius.circular(kRadius),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kRadius),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(kRadius),
                      hoverColor: hightlightColor,
                      splashColor: hightlightColor,
                      highlightColor: hightlightColor,
                      enableFeedback: true,
                      onTap: () {
                        navigationService.backTo(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: context.colorTheme.backBtnBackground,
                        ),
                        child: Builder(builder: (context) {
                          return backbtn;
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if (title.isNotEmpty) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 4),
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: Text(
                      title,
                      style: context.textTheme.titleSmall.withColor(titleColorV).style,
                    ),
                  ),
                ),
              ),
            ] else
              const Spacer(),
            // To Center the middle elements
            if (navigationService.canBack) const SizedBox(width: 42),
          ],
        ),
      ),
    );
  }
}
