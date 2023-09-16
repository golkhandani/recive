import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';

abstract class IEventRepo {
  Future<List<FeaturedEvent>> featuredEvents({
    required int limit,
    required ArtItemSortBy sortBy,
  });

  Future<List<FeaturedEvent>> categoryEvents({
    required int limit,
    required Category category,
  });

  Future<List<FeaturedEvent>> bookmarkEvents({
    required int limit,
    required List<String> ids,
  });

  Future<EventComplete> completeEventById({
    required String id,
  });
}
