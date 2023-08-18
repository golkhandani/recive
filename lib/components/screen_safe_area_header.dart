import 'package:flutter/widgets.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ScreenSafeAreaHeader extends StatelessWidget {
  const ScreenSafeAreaHeader({
    super.key,
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        height: context.viewTopPaddingHeight + context.headerHeight,
        color: color,
        child: Padding(
          padding: context.viewTopPadding,
          child: TitleHeader(
            title: title,
          ),
        ),
      ),
    );
  }
}
