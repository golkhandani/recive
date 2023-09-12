import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/layout/context_ui_extension.dart';

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
            color: context.colorScheme.secondaryContainer,
            size: 50,
          ),
        )
      ],
    );
  }
}
