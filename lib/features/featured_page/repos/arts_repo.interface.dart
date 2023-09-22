import 'package:recive/enums/event_sort.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/models/art_abstract_model.dart';
import 'package:recive/features/featured_page/models/art_model.dart';

abstract class IArtRepo {
  Future<List<ArtAbstractModel>> getFeaturedArts({
    required int limit,
    required ArtItemSortBy sortBy,
  });

  Future<List<ArtAbstractModel>> getCategoryArts({
    required int limit,
    required Category category,
  });

  Future<List<ArtAbstractModel>> getBookmarkArts({
    required int limit,
    required List<String> ids,
  });

  Future<ArtModel> getArtById({
    required String id,
  });
}
