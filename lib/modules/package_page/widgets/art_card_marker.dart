import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/modules/featured_page/models/art_abstract_model.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class EventCardMarker {
  const EventCardMarker({
    required this.data,
    required this.color,
    required this.fontColor,
    required this.onTap,
    this.useCompact = true,
  });

  final ArtAbstractModel data;
  final Color color;
  final Color fontColor;
  final VoidCallback? onTap;
  final bool useCompact;

  Marker marker(BuildContext context) => Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        rotateAlignment: AnchorAlign.top.rotationAlignment,
        height: useCompact ? 50 : 140,
        width: useCompact ? 50 : 280,
        point: data.geoLocation,
        rotate: true,
        builder: (ctx) => GestureDetector(
          onTap: onTap,
          child: CardContainer(
            borderRadius: kMediumBorderRadius,
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
                        borderRadius: kMediumBorderRadius,
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
      );
}
