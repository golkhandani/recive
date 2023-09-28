import 'package:recive/modules/package_page/models/art_route_model.dart';
import 'package:recive/modules/search_page/repos/search.repository.interface.dart';

abstract class ISearchRouteRepo implements IQuickSearchRepository {
  Future<List<ArtRouteAbstractModel>> search({
    required int limit,
    required String query,
    required double? distanceFilter,
    required ArtRouteAbstractModel? lastItem,
  });

  Future<List<String>> keywords({
    required int limit,
  });
}
