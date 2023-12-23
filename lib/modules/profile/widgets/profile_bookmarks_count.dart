import 'package:flutter/material.dart';

import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class ProfileBookmarksCount extends StatelessWidget {
  const ProfileBookmarksCount({
    super.key,
    required this.count,
    required this.isLoading,
    required this.onCountClicked,
  });

  final int count;
  final bool isLoading;
  final void Function() onCountClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Total bookmarks:",
            style: context.textTheme.titleTiny.onCardBackground.style,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InkWell(
            onTap: count == 0 ? null : onCountClicked,
            child: Container(
              padding: kTinyPadding,
              alignment: Alignment.center,
              constraints: const BoxConstraints.expand(
                height: 42,
              ),
              decoration: ShapeDecoration(
                color: count == 0
                    ? context.colorTheme.tabBarUnselected
                    : context.colorTheme.tabBarSelected,
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
                      count == 0 ? 'No items' : 'View $count items',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleTiny
                          .withColor(
                            count != 0
                                ? context.colorTheme.onTabBarSelected
                                : context.colorTheme.onTabBarUnselected,
                          )
                          .style,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
