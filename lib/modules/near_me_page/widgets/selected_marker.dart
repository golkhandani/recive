import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';

class SelectedMarker extends StatelessWidget {
  const SelectedMarker({
    super.key,
    required this.latLng,
  });

  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          height: 50,
          width: 50,
          point: latLng,
          rotate: true,
          builder: (ctx) => Icon(
            FluentIcons.location_12_filled,
            color: context.colorTheme.primary,
            size: 50,
          ),
        )
      ],
    );
  }
}

class SelectedMarker2Controller extends ValueNotifier<LatLng> {
  SelectedMarker2Controller(super.intialLatLng);

  void updateValue(LatLng latLng) {
    value = latLng;
  }
}

class SelectedMarker2 extends StatelessWidget {
  const SelectedMarker2({
    super.key,
    required this.controller,
  });

  final SelectedMarker2Controller controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, LatLng value, Widget? child) {
        return MarkerLayer(
          markers: [
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.top),
              rotateAlignment: AnchorAlign.top.rotationAlignment,
              height: 50,
              width: 50,
              point: controller.value,
              rotate: true,
              builder: (ctx) => Icon(
                FluentIcons.location_12_filled,
                color: context.colorTheme.primary,
                size: 50,
              ),
            )
          ],
        );
      },
    );
  }
}

class FlutterMapMarkerClusterLayerController
    extends ValueNotifier<List<Marker>> {
  FlutterMapMarkerClusterLayerController() : super([]);

  void updateValue(List<Marker> markers) {
    value = markers;
  }
}

class FlutterMapMarkerClusterLayer extends StatelessWidget {
  const FlutterMapMarkerClusterLayer({
    super.key,
    required this.controller,
  });

  final FlutterMapMarkerClusterLayerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) => MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
          maxClusterRadius: 45,
          size: const Size(40, 40),
          anchorPos: AnchorPos.align(
            AnchorAlign.center,
          ),
          fitBoundsOptions: const FitBoundsOptions(
            padding: EdgeInsets.all(50),
            maxZoom: 15,
          ),
          markers: value,
          builder: (context, markers) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.colorTheme.errorContainer,
              ),
              child: Center(
                child: Text(
                  markers.length.toString(),
                  style: TextStyle(
                    color: context.colorTheme.onErrorContainer,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
