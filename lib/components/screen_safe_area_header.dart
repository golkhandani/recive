import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ScreenSafeAreaHeader extends StatelessWidget {
  const ScreenSafeAreaHeader({
    super.key,
    this.color,
    required this.title,
    this.elevation = true,
  });

  final Color? color;
  final String title;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? context.colorScheme.tertiaryContainer;
    final tc = color ?? context.colorScheme.onTertiaryContainer;
    return SliverPinnedHeader(
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          boxShadow: elevation
              ? <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0.2, 0),
                    blurRadius: 4,
                    color: context.colorScheme.shadow,
                  )
                ]
              : null,
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
