import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';

abstract class IEventRepo {
  Future<List<FeaturedEvent>> featuredEvents({
    required int limit,
    required EventSortBy sortBy,
  });

  Future<List<FeaturedEvent>> favouriteEvents({
    required int limit,
    required List<String> ids,
  });

  Future<FeaturedEvent> featuredEventById({
    required String id,
  });

  Future<EventComplete> completeEventById({
    required String id,
  });
}
