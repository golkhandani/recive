import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';

enum EventSortByInput {
  startDateAsc,
  startDateDesc,
  ;
}

extension ConvertToGql on EventSortByInput {
  GEventSortByInput toGQL() {
    switch (this) {
      case EventSortByInput.startDateAsc:
        return GEventSortByInput.START_DATE_ASC;
      case EventSortByInput.startDateDesc:
        return GEventSortByInput.START_DATE_DESC;
      default:
        return GEventSortByInput.START_DATE_DESC;
    }
  }
}

abstract class IEventRepo {
  Future<List<FeaturedEvent>> events({
    required int limit,
    required EventSortByInput sortBy,
  });
  Future<FeaturedEvent> event({
    required String id,
  });

  Future<List<NearbyEvent>> nearbyEvents({
    required double latitude,
    required double longitude,
    required int minDistance,
    required int maxDistance,
  });

  Future<NearbyEvent> nearbyEvent({
    required String id,
  });
}
