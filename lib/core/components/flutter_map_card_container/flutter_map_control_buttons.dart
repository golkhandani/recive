import 'package:flutter/material.dart';

import 'package:flutter_map_animations/flutter_map_animations.dart';

import 'package:recive/core/components/flutter_map_card_container/cubit/map_control_cubit.dart';
import 'package:recive/core/components/flutter_map_card_container/map_card_container.dart';
import 'package:recive/modules/near_me_page/widgets/map_button.dart';

class FlutterMapControlButtons extends StatelessWidget {
  const FlutterMapControlButtons({
    super.key,
    required this.mapState,
    required this.mapBloc,
    required this.mapController,
  });

  final MapControlState mapState;
  final MapControlCubit mapBloc;
  final AnimatedMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MapButton(
                icon: Icons.center_focus_strong,
                onClicked: () {
                  mapController.animateTo(dest: mapState.userLocation);
                }),
            MapButton(
              icon: Icons.zoom_in,
              onClicked: () {
                if (mapState.zoom > MapCardContainer.maxZoom) {
                  return;
                }
                final updatedZoom = mapState.zoom + 1;
                mapBloc.updateState(
                  mapState.copyWith(zoom: updatedZoom),
                );
                mapController.animatedZoomTo(
                  updatedZoom,
                );
              },
            ),
            MapButton(
              icon: Icons.zoom_out,
              onClicked: () {
                if (mapState.zoom < MapCardContainer.minZoom) {
                  return;
                }
                final updatedZoom = mapState.zoom - 1;
                mapBloc.updateState(
                  mapState.copyWith(zoom: updatedZoom),
                );
                mapController.animatedZoomTo(
                  updatedZoom,
                );
              },
            ),
            MapButton(
              icon: Icons.near_me_outlined,
              onClicked: () {
                mapController.animatedRotateReset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
