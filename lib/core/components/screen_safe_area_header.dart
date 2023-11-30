import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/title_header.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class ScreenSafeAreaHeader extends StatelessWidget {
  const ScreenSafeAreaHeader({
    super.key,
    this.color,
    this.backgroundColor,
    required this.title,
    this.elevation = true,
  });

  final Color? color;
  final Color? backgroundColor;
  final String title;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final bg = context.colorScheme.tertiaryContainer;
    final tc = color ?? context.colorScheme.onTertiaryContainer;
    return SliverPinnedHeader(
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          // boxShadow: elevation
          //     ? <BoxShadow>[
          //         BoxShadow(
          //           offset: const Offset(0.1, 0.1),
          //           blurRadius: 0.5,
          //           color: context.colorScheme.shadow,
          //         )
          //       ]
          //     : null,
          borderRadius: BorderRadius.zero,
        ),
        height: context.viewTopPaddingHeight + context.headerHeight,
        child: Padding(
          padding: context.viewTopPadding,
          child: TitleHeader(
            title: title,
            backgroundColor: bg,
            titleColor: tc,
          ),
        ),
      ),
    );
  }
}
