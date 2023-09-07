import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:intl/intl.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/layout/context_ui_extension.dart';

class EventCardMarker extends StatelessWidget {
  const EventCardMarker({
    super.key,
    required this.data,
    required this.color,
    required this.fontColor,
    required this.onTap,
    this.useCompact = true,
  });

  final NearbyEvent data;
  final Color color;
  final Color fontColor;
  final VoidCallback? onTap;
  final bool useCompact;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: AnchorAlign.top.rotationAlignment,
          height: useCompact ? 50 : 140,
          width: useCompact ? 50 : 280,
          point: data.latLng,
          rotate: true,
          builder: (ctx) => GestureDetector(
            onTap: onTap,
            child: CardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(4),
              color: color,
              child: Row(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: data.imageUrl,
                      placeholder: (context, _) => const SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        height: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            opacity: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  if (!useCompact) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            maxLines: 3,
                            style: context.labelLargeOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat.yMMMd().format(data.startDate),
                            maxLines: 1,
                            style: context.labelSmallOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.location,
                            maxLines: 2,
                            style: context.labelSmallOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                        ],
                      ),
                    )
                  ]
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
