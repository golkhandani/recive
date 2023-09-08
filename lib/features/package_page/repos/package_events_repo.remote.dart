import 'dart:math';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';
import 'package:starsview/utils/RandomUtils.dart';

import 'package:recive/domain/graphql/__generated__/events_query.req.gql.dart';
import 'package:recive/enums/event_sort.dart';
import 'package:recive/extensions/duration_extensions.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/ioc/routing_machine_service.dart';
import 'package:recive/key_constants.dart';

class GQLPackageEventRepo extends IPackageEventRepo {
  final RealmGqlClient client;
  final RoutingMachineService rms;

  GQLPackageEventRepo({
    required this.client,
    required this.rms,
  });

  @override
  Future<Package> packageById({required String id}) {
    throw UnimplementedError();
  }

  Future<List<NearbyEvent>> _events({
    required int limit,
    required EventSortBy sortBy,
  }) async {
    final featuredEventRequest = GGetFeaturedEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.sortBy = sortBy.toGQL(),
    );

    final data = await client.request(featuredEventRequest);
    final convertedData = data.data?.events
            .map(
              (e) => NearbyEvent(
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
                tags: e.tags?.whereNotNull().toList() ?? [],
                latLng: LatLng(
                  double.tryParse(e.venue!.address!.latitude!) ?? 0,
                  double.tryParse(e.venue!.address!.longitude!) ?? 0,
                ),
              ),
            )
            .whereType<NearbyEvent>()
            .toList() ??
        [];

    return convertedData;
  }

  // ignore: unused_element
  _gpt() async {
    final openAI = OpenAI.instance.build(
      token: openAiSk,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );

    final request = ChatCompleteText(
        maxToken: 200,
        model: GptTurbo0631Model(),
        messages: [
          Messages(
            role: Role.user,
            content:
                '''Combine this items and give me an interesting navigation guide with real data 
                  -> here is the original guide 
                  -> }''',
            name: "get_current_weather",
          ),
        ],
        functionCall: FunctionCall.auto);

    final response = await openAI.onChatCompletion(request: request);

    locator.logger.d(response);
  }

  @override
  Future<List<Package>> packages({required int limit}) async {
    final events = await _events(
      limit: limit * 3,
      sortBy: EventSortBy.startDateDesc,
    );

    final counter = List.generate(limit, (i) => i);
    final list = <Package>[];
    for (var count in counter) {
      events.shuffle();
      final packageEvents = events.take(3);
      final way = rms.convertPointsToWay(
        packageEvents.map((e) => e.latLng).toList(),
      );
      final road = await rms.getRoad(way);
      final destinations = await rms.getDestinations(road);
      final polyline = rms.getPolyline(road);
      final stepByStepInstruction =
          await rms.getInstructionsByDestinations(road);
      final duration = Duration(seconds: road.duration.toInt());
      final tags = packageEvents.expand((e) => e.tags).toList();

      locator.logger.d(stepByStepInstruction);

      list.add(Package(
        id: '$count',
        title:
            '${duration.toHoursMinutes()} of ${tags.randomElement(Random())}',
        subtitle: destinations.isNotEmpty
            ? 'From ${destinations.first} to ${destinations.last}'
            : '',
        description: 'You going to visit ${destinations.join(' ')}',
        imageUrl: packageEvents.last.imageUrl,
        tags: tags,
        events: packageEvents.toList(),
        roadInstructions: stepByStepInstruction,
        distance: road.distance,
        duration: duration,
        polyline: polyline ?? [],
      ));
    }

    return list;
  }
}
