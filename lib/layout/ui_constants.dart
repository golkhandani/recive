import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterMapAttribution extends StatelessWidget {
  const FlutterMapAttribution({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichAttributionWidget(
      permanentHeight: 12,
      attributions: [
        TextSourceAttribution(
          'OpenStreetMap contributors',
          onTap: () => launchUrl(Uri.parse(
            'https://openstreetmap.org/copyright',
          )),
        ),
      ],
    );
  }
}

class FlutterMapTileLayer extends StatelessWidget {
  const FlutterMapTileLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
      // 'https://api.maptiler.com/maps/pastel/{z}/{x}/{y}.png?key=cKGhx1kSOrw1anX1ljgw',
      tileProvider: locator.get(),
    );
  }
}

class UserMarker extends StatelessWidget {
  const UserMarker({
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

const kSliverFillLoading = SliverFillRemaining(
  child: Center(
    child: CircularProgressIndicator(),
  ),
);

const kMediumPadding = EdgeInsets.all(16);
const kSmallPadding = EdgeInsets.all(12);
const kTinyPadding = EdgeInsets.all(8);

const Widget kLoadingBox = Center(
  child: SizedBox(
    height: 32.0,
    width: 32.0,
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  ),
);
const Widget kErrorIcon = Icon(Icons.error);

final kStandardBlur = ImageFilter.blur(
  tileMode: TileMode.clamp,
  sigmaX: 10.0,
  sigmaY: 10.0,
);

final kBoxBorder = Border.all(
  color: primaryShadow,
  width: 1,
  style: BorderStyle.solid,
);

final kStandardBlurColor =
    const Color.fromARGB(255, 40, 40, 40).withOpacity(0.6);

const double kRadius = 10;
