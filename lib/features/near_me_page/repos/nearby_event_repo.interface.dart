import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';

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

abstract class INearbyEventRepo {
  Future<EventComplete> event({
    required String id,
  });
}
