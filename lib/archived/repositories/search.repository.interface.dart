import 'package:recive/archived/models/recive.model.dart';

abstract class ISearchRepository {
  Future<List<String>> quickSearch({required String query});
  Future<List<Recive>> search();
}
