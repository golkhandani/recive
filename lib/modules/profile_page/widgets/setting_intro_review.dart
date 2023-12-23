import 'package:flutter/material.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';

class SettingIntroReview extends StatelessWidget {
  const SettingIntroReview({
    super.key,
    required this.onIntroViewedChanged,
    required this.isIntroViewed,
  });

  final bool isIntroViewed;
  final void Function(bool) onIntroViewedChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Intro has been viewed:",
          style: context.textTheme.titleTiny.onCardBackground.style,
        ),
        const Spacer(),
        Theme(
          data: ThemeData(useMaterial3: true),
          child: Switch(
            value: isIntroViewed,
            trackOutlineWidth: const MaterialStatePropertyAll(0),
            activeColor: context.colorTheme.tabBarSelected,
            inactiveTrackColor: context.colorTheme.tabBarUnselected,
            inactiveThumbColor: context.colorTheme.onTabBarUnselected,
            onChanged: onIntroViewedChanged,
          ),
        ),
      ],
    );
  }
}
