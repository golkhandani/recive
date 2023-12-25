import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/title_header.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class ScreenSafeAreaHeader extends StatelessWidget {
  const ScreenSafeAreaHeader({
    super.key,
    this.color,
    this.backgroundColor,
    required this.title,
    this.children,
    this.elevation = true,
  });

  final Color? color;
  final Color? backgroundColor;
  final String title;
  final bool elevation;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    final bg = context.colorTheme.navBackground;
    final tc = color ?? context.colorTheme.onNavBackground;
    return SliverPinnedHeader(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0, tileMode: TileMode.repeated),
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                SizedBox(
                  height: kToolbarHeight,
                  child: TitleHeader(
                    title: title,
                    backgroundColor: Colors.transparent,
                    titleColor: tc,
                  ),
                ),
                ...?children
              ],
            ),
          ),
        ),
      ),
    );
  }
}
