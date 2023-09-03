import 'dart:ffi';

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
  });

  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? context.colorScheme.tertiaryContainer;
    final tc = color ?? context.colorScheme.onTertiaryContainer;
    return SliverPinnedHeader(
      child: Container(
        height: context.viewTopPaddingHeight + context.headerHeight,
        color: bg,
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
