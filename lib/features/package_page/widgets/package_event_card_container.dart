import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class PackageEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final List<String> roadInstructions;

  PackageEventCardContainerData(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.organizers,
      required this.participants,
      required this.imageUrl,
      required this.roadInstructions});

  static PackageEventCardContainerData fromNearbyEvent(
      NearbyEvent e, List<String>? instructions) {
    return PackageEventCardContainerData(
        id: e.id,
        title: e.title,
        description: e.description,
        startDate: e.startDate,
        endDate: e.endDate,
        location: e.location,
        organizers: e.organizers,
        participants: e.participants,
        imageUrl: e.imageUrl,
        roadInstructions: instructions ?? []);
  }

  static PackageEventCardContainerData fromEventComplete(
    EventComplete e,
    List<String>? instructions,
  ) {
    return PackageEventCardContainerData(
        id: e.id!,
        title: e.title!,
        description: e.description!,
        startDate: e.startDate!,
        endDate: e.endDate!,
        location: e.venue?.address?.localizedAddressDisplay ?? '',
        organizers: [e.organizer?.title ?? ''],
        participants: [],
        imageUrl: e.imageUrl!,
        roadInstructions: instructions ?? []);
  }
}

class PackageEventCardContainer extends HookWidget {
  const PackageEventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
    required this.parentRoute,
    required this.parentPathParams,
  });

  final BoxConstraints constraints;
  final PackageEventCardContainerData data;
  final String parentRoute;
  final Map<String, String> parentPathParams;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.theme.colorScheme.secondaryContainer.withOpacity(0.6);
    final fontColor = context.colorScheme.onTertiaryContainer;
    final heroTag = parentRoute + data.id;
    final extraJson = ExtraData(
      summary: FeaturedEventDetailSummaryData(
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
                      Iconify(
                        Bx.bxs_map,
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

    return InkWell(
      onTap: () => navigationService.pushTo(
        parentRoute + FeaturedEventDetailScreen.name,
        pathParameters: {
          ...parentPathParams,
          FeaturedEventDetailScreen.pathParamId: data.id,
        },
        extra: extraJson,
      ),
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
            child
          ],
        ),
      );
    });
  }
}
