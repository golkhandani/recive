import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:debounce_hook/debounce_hook.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/near_me_page/cubits/map_control_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container_data.dart';
import 'package:recive/features/near_me_page/widgets/map_button.dart';
import 'package:recive/features/near_me_page/widgets/selected_marker.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/flutter_map/flutter_map_attribution.dart';
import 'package:recive/layout/flutter_map/flutter_map_tile_layer.dart';
import 'package:recive/layout/flutter_map/flutter_map_user_marker.dart';
import 'package:recive/layout/ui_constants.dart';

part '__map_content.dart';
part '__carousel_content.dart';

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
  final NearbyEventsCubit bloc;
  final NearbyEventsState state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2),
      sliver: MultiSliver(
        children: [
          _MapContent(
            mapSectionHeight: mapSectionHeight,
            mapController: mapController,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 12),
          _CarouselContent(
            switchIndex: switchIndex,
            listSectionHeight: listSectionHeight,
            mapController: mapController,
            bloc: bloc,
            state: state,
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}
