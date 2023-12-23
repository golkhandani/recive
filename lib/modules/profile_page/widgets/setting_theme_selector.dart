import 'package:flutter/material.dart';

import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/shared/extensions/string_extensions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class SettingThemeSelector extends StatelessWidget {
  const SettingThemeSelector({
    super.key,
    required this.selectedTheme,
    required this.onThemeChanged,
  });

  final AppPaletteType selectedTheme;
  final void Function(int index) onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Theme:",
          style: context.textTheme.titleTiny.onCardBackground.style,
        ),
        const Spacer(),
        ToggleSwitch(
          minHeight: 42.0,
          fontSize: context.textTheme.hint.style.fontSize!,
          initialLabelIndex: selectedTheme.index,
          activeBgColor: [selectedTheme.colorPalette.primary],
          activeFgColor: selectedTheme.colorPalette.onPrimary,
          inactiveBgColor: context.colorTheme.tabBarUnselected,
          inactiveFgColor: context.colorTheme.onTabBarUnselected,
          totalSwitches: AppPaletteType.values.length,
          animationDuration: 0,
          labels: AppPaletteType.values
              .map(
                (e) => e.name.toCapitalized(),
              )
              .toList(),
          animate: true,
          onToggle: (index) {
            final val = index ?? 0;
            onThemeChanged(val);
          },
        ),
      ],
    );
  }
}
