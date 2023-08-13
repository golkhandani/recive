import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:recive/archived/featured_page/quick_search_header/quick_search_header_component.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/sliver_header_delegate.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends HookWidget {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultState = useState(0);
    final textEditingController = useTextEditingController();

    return ColoredBox(
      color: Colors.amber[100]!,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight =
            box.maxHeight - context.invisibleHeight - 24 - 56 - 12 - 24;
        return CustomScrollView(
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Profile',
            ),
            SliverPinnedHeader(
              child: ClipPath(
                clipper: SinCosineWaveClipper(
                  verticalPosition: VerticalPosition.bottom,
                  horizontalPosition: HorizontalPosition.right,
                ),
                child: Container(
                  height: 200,
                  color: context.theme.primaryColor,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 12,
                        right: 24,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 72,
                        ),
                      ),
                      Positioned(
                        top: 24,
                        left: 24,
                        right: 72 * 2 + 24 + 12,
                        child: Text(
                          "Mohammadreza Rahimiangolkhandani - (Comming soon!!!)",
                          style: context.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: CardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.yellowAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
