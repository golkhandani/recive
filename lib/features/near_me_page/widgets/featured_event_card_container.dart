import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/features/near_me_page/widgets/featured_event_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class FeaturedArtCardContainer extends HookWidget {
  const FeaturedArtCardContainer({
    super.key,
    required this.data,
    required this.constraints,
    this.hero,
    this.parentPathParams = const {},
  });

  final BoxConstraints constraints;
  final FeaturedArtCardContainerData data;
  final String? hero;
  final Map<String, String> parentPathParams;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.theme.colorScheme.secondaryContainer;
    final fontColor = context.colorScheme.onSecondaryContainer;
    final heroTag = hero ?? DateTime.now().toString();

    final extraJson = ExtraData(
      summary: FeaturedEventDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());

    final child = LayoutBuilder(builder: (context, box) {
      final isBig = MediaQuery.sizeOf(context).width / 2 < box.maxWidth;
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < box.maxHeight / 1;

      if (isBig && !isSmallTall) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                // color: color,
                padding: const EdgeInsets.all(8).copyWith(top: 36),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      color,
                      color.withOpacity(0.9),
                      color.withOpacity(0.7),
                      color.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      style: context.titleMediumOnPrimaryContainer
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
                            maxLines: isSmallTall ? 3 : 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleSmallOnPrimaryContainer
                                .withColor(fontColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      if (isSmallTall && !isSmall) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        color,
                        color.withOpacity(0.9),
                        color.withOpacity(0.7),
                        color.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(8).copyWith(top: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleMediumOnPrimaryContainer
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
                              maxLines: isSmallTall ? 3 : 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmallOnPrimaryContainer
                                  .withColor(fontColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                width: box.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color,
                      color.withOpacity(0.9),
                      color.withOpacity(0.7),
                      color.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8).copyWith(bottom: 36),
                child: Text(
                  data.title,
                  maxLines: 2,
                  style: context.titleMediumOnPrimaryContainer
                      .withColor(fontColor),
                ),
              ),
            ),
          ),
        ],
      );
    });

    return RepaintBoundary(
      child: InkWell(
        onTap: () => {
          navigationService.pushTo(
            NearMeScreen.name + NearbyDetailScreen.name,
            pathParameters: {
              ...parentPathParams,
              NearbyDetailScreen.pathParamId: data.id,
            },
            extra: extraJson,
          ),
        },
        child: Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: data.imageUrl,
            imageBuilder: (context, imageProvider) =>
                _buildEventCard(imageProvider, color, child),
            placeholder: (context, url) => _buildEventLoading(color),
            errorWidget: (context, url, error) =>
                _buildEventCard(null, color, child),
          ),
        ),
      ),
    );
  }

  Container _buildEventLoading(Color color) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: child,
    );
  }
}