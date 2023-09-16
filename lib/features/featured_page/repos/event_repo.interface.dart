import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';

abstract class IEventRepo {
  Future<List<ArtAbstractModel>> featuredEvents({
    required int limit,
    required ArtItemSortBy sortBy,
  });

  Future<List<ArtAbstractModel>> categoryEvents({
    required int limit,
    required Category category,
  });

  Future<List<ArtAbstractModel>> bookmarkEvents({
    required int limit,
    required List<String> ids,
  });

  Future<ArtModel> completeEventById({
    required String id,
  });
}
