import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';

abstract class ISearchEventRepo implements IQuickSearchRepository {
  Future<List<PackageAbstract>> search({
    required int limit,
    required String query,
    required double? distanceFilter,
    required PackageAbstract? lastItem,
  });

  Future<List<String>> keywords({
    required int limit,
  });
}
