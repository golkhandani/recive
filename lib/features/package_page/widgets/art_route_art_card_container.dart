import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/package_page/widgets/art_route_art_card_container_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class ArtRouteCardContainer extends HookWidget {
  const ArtRouteCardContainer({
    super.key,
    required this.data,
    required this.constraints,
    required this.parentRoute,
    required this.parentPathParams,
  });

  final BoxConstraints constraints;
  final ArtRouteArtCardContainerData data;
  final String parentRoute;
  final Map<String, String> parentPathParams;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.theme.colorScheme.secondaryContainer.withOpacity(0.6);
    final fontColor = context.colorScheme.onTertiaryContainer;
    final heroTag = parentRoute + data.id;
    final extraJson = ExtraData(
      summary: ArtDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());

    final child = LayoutBuilder(builder: (context, box) {
      final isSmallTall = box.maxWidth < box.maxHeight / 1;
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    style: context.titleLargeOnPrimaryContainer
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
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      );
    });

    return RepaintBoundary(
      child: InkWell(
        onTap: () => navigationService.pushTo(
          parentRoute + ArtDetailScreen.name,
          pathParameters: {
            ...parentPathParams,
            ArtDetailScreen.pathParamId: data.id,
          },
          extra: extraJson,
        ),
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildEventCard(imageProvider, color, heroTag, child),
          placeholder: (context, url) => _buildEventLoading(color),
          errorWidget: (context, url, error) =>
              _buildEventCard(null, color, heroTag, child),
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

  Builder _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    String heroTag,
    Widget child,
  ) {
    return Builder(builder: (context) {
      final fontColor = context.colorScheme.onTertiaryContainer;
      return Container(
        constraints: constraints,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (data.roadInstructions.isNotEmpty) ...[
              Center(
                child: Text.rich(
                  TextSpan(
                    children: data.roadInstructions.mapIndexed((i, t) {
                      final isDestination = t.contains('destination');
                      return TextSpan(
                        text: '${i == 0 ? '' : '\n↵'} $t',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: isDestination
                              ? context.colorScheme.secondary
                              : fontColor,
                          fontWeight: isDestination ? FontWeight.bold : null,
                          fontSize: isDestination ? 20 : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            Expanded(
              child: Hero(
                tag: heroTag,
                child: Container(
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
                  padding: kTinyPadding,
                ),
              ),
            ),
            child
          ],
        ),
      );
    });
  }
}