import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/map_card_container/map_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';

class HomePageMapSection extends HookWidget {
  const HomePageMapSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Find Arts on map",
            style: context.textTheme.headlineSmall?.withColor(
              context.colorScheme.onBackground,
            ),
          ),
        ),
        const SliverGap(height: 12),
        SliverStack(
          children: [
            MapCardContainer(
              markers: const [],
              height: 120,
              showControls: false,
              onMapContainerCliked: () {
                navigationService.moveTo(NearMeScreen.name);
              },
              userLocationCentered: true,
            ),
            SliverPositioned.fill(
              child: Center(
                child: Icon(
                  Icons.touch_app,
                  color: context.colorScheme.secondaryContainer,
                  size: 50,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
