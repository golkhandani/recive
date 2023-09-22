import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/near_me_page/widgets/featured_event_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class FeaturedEventExpandedCardContainer extends HookWidget {
  const FeaturedEventExpandedCardContainer({
    super.key,
    required this.data,
  });

  final FeaturedArtCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.surface;
    final fontColor = context.colorScheme.onSurface;
    final extra = ExtraData(
      summary: FeaturedEventDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: data.id,
    ).toJson((inner) => inner.toJson());
    return RepaintBoundary(
      child: InkWell(
        onTap: () => navigationService.pushTo(
          FeaturedScreen.name + NearbyDetailScreen.name,
          pathParameters: {
            NearbyDetailScreen.pathParamId: data.id,
          },
          extra: extra,
        ),
        child: CardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: kTinyPadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color,
            ),
            child: Column(
              children: [
                Hero(
                  tag: data.id,
                  child: CachedNetworkImage(
                    imageUrl: data.imageUrl,
                    placeholder: (context, url) => const SizedBox(height: 200),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          opacity: 0.9,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    header: Text(
                      data.title,
                      style:
                          context.titleLargeOnBackground.withColor(fontColor),
                    ),
                    collapsed: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kTinyPadding.horizontal / 2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FluentIcons.location_12_filled,
                            color: fontColor,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              data.location,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                              style: context.labelLargeOnBackground
                                  .withColor(fontColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        vertical: kTinyPadding.horizontal / 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.description,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            style: context.labelLargeOnBackground
                                .withColor(fontColor),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                FluentIcons.location_12_filled,
                                color: fontColor,
                                size: 24,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  data.location,
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  style: context.textTheme.labelLarge!
                                      .withColor(fontColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    theme: ExpandableThemeData(
                      iconSize: 20,
                      iconPadding: const EdgeInsets.only(bottom: 12),
                      iconColor: fontColor,
                      animationDuration: const Duration(milliseconds: 200),
                      useInkWell: true,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
