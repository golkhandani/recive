import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
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
