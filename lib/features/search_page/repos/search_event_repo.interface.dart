import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';

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

abstract class ISearchEventRepo implements ISearchRepository {
  Future<List<EventComplete>> search({
    required int limit,
    required String query,
  });

  Future<List<String>> keywords({
    required int limit,
  });
}
