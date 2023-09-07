import 'package:recive/domain/graphql/__generated__/schema.schema.gql.dart';

enum EventSortBy {
  startDateAsc,
  startDateDesc,
  ;
}

extension ConvertToGql on EventSortBy {
  GEventSortByInput toGQL() {
    switch (this) {
      case EventSortBy.startDateAsc:
        return GEventSortByInput.START_DATE_ASC;
      case EventSortBy.startDateDesc:
        return GEventSortByInput.START_DATE_DESC;
      default:
        return GEventSortByInput.START_DATE_DESC;
    }
  }
}
