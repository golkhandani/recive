import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/services/geo_location_service.dart';

class FlutterMapUserMarker extends StatelessWidget {
  const FlutterMapUserMarker({
    super.key,
    required this.geolocation,
  });

  final Position geolocation;

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitRipple(
      color: context.colorTheme.secondaryContainer,
      size: 50.0,
    );
    return MarkerLayer(
      markers: [
        Marker(
          point: geolocation.latLng!,
          width: 80,
          height: 80,
          builder: (context) => RepaintBoundary(child: spinkit),
        ),
      ],
    );
  }
}
