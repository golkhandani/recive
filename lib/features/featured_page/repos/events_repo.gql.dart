import 'dart:math';

import 'package:collection/collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:objectid/objectid.dart';
import 'package:recive/domain/graphql/__generated__/event_query.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/events_query.req.gql.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';

class GQLEventRepo extends IEventRepo {
  final Client client;

  GQLEventRepo({
    required this.client,
  });

  @override
  Future<FeaturedEvent> event({required String id}) async {
    final featuredEventRequest =
        GGetFeaturedEventReq((b) => b..vars.eventId.value = id);

    final data = await client.request(featuredEventRequest).map((element) {
      if (kDebugMode) {
        print(
            "_________________| featuredEventRequest ${element.loading} ${element.data?.event?.G_id?.value}");
      }
      return element;
    }).firstWhere((element) => !element.loading);

    final e = data.data!.event!;

    return FeaturedEvent(
      id: e.G_id!.value,
      title: e.name ?? '',
      description: e.summary ?? '',
      startDate: e.start_date?.value != null
          ? DateTime.parse(e.start_date!.value)
          : DateTime.now(),
      endDate: e.end_date?.value != null
          ? DateTime.parse(e.start_date!.value)
          : DateTime.now(),
      location: e.venue?.address?.localized_address_display ?? '',
      organizers: [e.organizer?.website_url ?? '']
          .whereNot((element) => element.isEmpty)
          .toList(),
      participants: [e.eventbrite_url ?? '']
          .whereNot((element) => element.isEmpty)
          .toList(),
      imageUrl: e.image_url ?? '',
    );
  }

  @override
  Future<List<FeaturedEvent>> events({
    required int limit,
    required EventSortByInput sortBy,
  }) async {
    final featuredEventRequest = GGetFeaturedEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.sortBy = sortBy.toGQL(),
    );

    final data = await client.request(featuredEventRequest).map((element) {
      if (kDebugMode) {
        print(
            "_________________| featuredEventRequest ${element.loading} ${element.data?.events.length}");
      }
      return element;
    }).firstWhere((element) => !element.loading);

    final convertedData = data.data?.events
            .map(
              (e) => FeaturedEvent(
                id: e!.G_id!.value,
                title: e.name ?? '',
                description: e.summary ?? '',
                startDate: e.start_date?.value != null
                    ? DateTime.parse(e.start_date!.value)
                    : DateTime.now(),
                endDate: e.end_date?.value != null
                    ? DateTime.parse(e.start_date!.value)
                    : DateTime.now(),
                location: e.venue?.address?.localized_address_display ?? '',
                organizers: [e.organizer?.website_url ?? '']
                    .whereNot((element) => element.isEmpty)
                    .toList(),
                participants: [e.eventbrite_url ?? '']
                    .whereNot((element) => element.isEmpty)
                    .toList(),
                imageUrl: e.image_url ?? '',
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }
}
