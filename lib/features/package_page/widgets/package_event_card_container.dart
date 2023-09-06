import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
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

  PackageEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });

  static PackageEventCardContainerData fromFeaturedEvent(FeaturedEvent e) {
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
    );
  }

  static PackageEventCardContainerData fromEventComplete(EventComplete e) {
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
    );
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
      final isBig = MediaQuery.sizeOf(context).width / 2 < box.maxWidth;
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < box.maxHeight / 1;
      final contentColor = context.colorScheme.onSecondary;
      if (isBig) {
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
                          .withColor(contentColor),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Iconify(
                          Bx.calendar_event,
                          color: context.colorScheme.onSecondary,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleMediumOnPrimaryContainer
                                .withColor(contentColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Iconify(
                          Bx.bxs_map,
                          color: contentColor,
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            data.location,
                            maxLines: isSmallTall ? 3 : 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleSmallOnPrimaryContainer
                                .withColor(contentColor),
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

      if (isSmallTall && isSmall) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: color,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.title,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleLargeOnPrimaryContainer,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Iconify(
                            Bx.calendar_event,
                            color: color.lighten(0.7),
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleMediumOnPrimaryContainer,
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
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: box.maxWidth,
                color: color,
                padding: const EdgeInsets.all(8),
                child: Text(
                  data.title,
                  maxLines: 3,
                  style: context.titleLargeOnPrimaryContainer,
                ),
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

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      child: Column(
        children: [
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
  }
}
