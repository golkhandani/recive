import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:recive/ioc/locator.dart';

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
