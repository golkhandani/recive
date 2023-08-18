import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileScreen extends HookWidget {
  static const name = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
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
