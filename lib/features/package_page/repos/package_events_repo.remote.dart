import 'package:collection/collection.dart';
import 'package:recive/domain/graphql/__generated__/events_query.req.gql.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLPackageEventRepo extends IPackageEventRepo {
  final RealmGqlClient client;

  GQLPackageEventRepo({
    required this.client,
  });

  @override
  Future<Package> packageById({required String id}) {
    throw UnimplementedError();
  }

  Future<List<FeaturedEvent>> _events({
    required int limit,
    required EventSortByInput sortBy,
  }) async {
    final featuredEventRequest = GGetFeaturedEventsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.sortBy = sortBy.toGQL(),
    );

    final data = await client.request(featuredEventRequest);
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
                tags: e.tags?.whereNotNull().toList() ?? [],
              ),
            )
            .whereType<FeaturedEvent>()
            .toList() ??
        [];

    return convertedData;
  }

  @override
  Future<List<Package>> packages({required int limit}) async {
    final events = await _events(
      limit: limit * 3,
      sortBy: EventSortByInput.startDateDesc,
    );

    return List.generate(limit, (index) {
      events.shuffle();
      final packageEvents = events.take(4);
      return Package(
        id: '$index',
        title: 'Package title $index',
        subtitle: 'Package subtitle $index',
        description: 'Package description $index : $article',
        imageUrl: events.last.imageUrl,
        tags: packageEvents.expand((e) => e.tags).toList(),
        events: packageEvents.toList(),
      );
    });
  }
}
