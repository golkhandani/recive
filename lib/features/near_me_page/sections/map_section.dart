import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/features/near_me_page/sections/map_section_content/__carousel_content.dart';
import 'package:recive/features/near_me_page/sections/map_section_content/__map_content.dart';
import 'package:recive/layout/ui_constants.dart';

class NearMeScreenMapViewContent extends HookWidget {
  const NearMeScreenMapViewContent({
    super.key,
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
    required this.state,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyCubit bloc;
  final NearbyState state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2),
      sliver: MultiSliver(
        children: [
          NearbyMapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 12),
          NearbyCarouselContent(
            listSectionHeight: listSectionHeight,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}
