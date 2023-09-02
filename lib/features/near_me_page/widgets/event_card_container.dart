import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/router/navigation_service.dart';

class EventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final LatLng latLng;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;

  EventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.latLng,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });

  static EventCardContainerData fromFeaturedEvent(NearbyEvent e) {
    return EventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      startDate: e.startDate,
      endDate: e.endDate,
      location: e.location,
      organizers: e.organizers,
      participants: e.participants,
      imageUrl: e.imageUrl,
      latLng: e.latLng,
    );
  }
}

class EventCardContainer extends StatelessWidget {
  const EventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final EventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme.secondaryContainer;

    final child = LayoutBuilder(builder: (context, box) {
      final isSmall = box.maxHeight < 160;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            maxLines: 1,
            style: context.titleLargeOnPrimaryContainer,
          ),
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
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          if (!isSmall) ...[
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
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Iconify(
                  Bx.briefcase,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    data.organizers.join(' '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      );
    });

    final heroTag = data.id + DateTime.now().toString();
    const route = NearMeScreen.name + NearbyDetailScreen.name;
    final extra = ExtraData(
      summary: NearbyDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    );
    final pathParams = {
      DetailScreen.pathParamId: data.id,
    };
    final navigationService = locator.get<NavigationService>();
    final extraJson = extra.toJson((inner) => inner.toJson());

    return InkWell(
      onTap: () {
        navigationService.navigateTo(
          route,
          pathParameters: pathParams,
          extra: extraJson,
        );
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
                opacity: 0.2,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.4),
            color.darken(0.2),
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
