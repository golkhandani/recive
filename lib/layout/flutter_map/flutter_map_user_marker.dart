import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:recive/ioc/geo_location_service.dart';

class FlutterMapUserMarker extends StatelessWidget {
  const FlutterMapUserMarker({
    super.key,
    required this.geolocation,
  });

  final Position geolocation;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: geolocation.latLng!,
          width: 80,
          height: 80,
          builder: (context) => LoadingAnimationWidget.beat(
            color: const Color.fromARGB(255, 8, 12, 93),
            size: 25,
          ),
        ),
      ],
    );
  }
}
