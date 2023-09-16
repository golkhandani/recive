import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';

abstract class ISearchEventRepo implements ISearchRepository {
  Future<List<ArtModel>> search({
    required int limit,
    required String query,
  });

  Future<List<String>> keywords({
    required int limit,
  });
}
