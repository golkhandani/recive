import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/search_page/search_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class SearchEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final LatLng latlng;

  SearchEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
    required this.latlng,
  });

  static SearchEventCardContainerData fromEventComplete(EventComplete e) {
    return SearchEventCardContainerData(
      id: e.id!,
      title: e.title!,
      description: e.description!,
      startDate: e.startDate!,
      endDate: e.endDate!,
      location: e.venue?.address?.localizedAddressDisplay ?? '',
      organizers: [e.organizer?.title ?? ''],
      participants: [],
      imageUrl: e.imageUrl!,
      latlng: e.venue?.latLng ?? const LatLng(0, 0),
    );
  }
}

class SearchEventCardContainer extends HookWidget {
  const SearchEventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final SearchEventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.colorScheme.tertiaryContainer.withOpacity(0.6);

    final child = LayoutBuilder(builder: (context, box) {
      final isShort = box.maxHeight < 120;
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: color,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.title,
                      maxLines: 1,
                      style: context.titleMediumOnPrimaryContainer,
                    ),
                    if (isShort) ...[
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
                              style: context.titleSmallOnPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Iconify(
                          Bx.bxs_map,
                          color: color.lighten(0.7),
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            data.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleSmallOnPrimaryContainer,
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
    });
    final heroTag = data.id + DateTime.now().toString();
    final extraJson = ExtraData(
      summary: NearbyDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
    return InkWell(
      onTap: () => navigationService.pushTo(
        SearchScreen.name + NearbyDetailScreen.name,
        pathParameters: {
          NearbyDetailScreen.pathParamId: data.id,
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
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.1),
            color.darken(0.3),
          ],
        ),
      ),
      padding: kTinyPadding,
      child: child,
    );
  }
}