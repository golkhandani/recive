import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
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
          builder: (ctx) => Iconify(
            Bx.bxs_map,
            color: context.colorScheme.tertiaryContainer,
            size: 50,
          ),
        )
      ],
    );
  }
}
