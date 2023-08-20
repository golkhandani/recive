abstract class ISearchRepository {
  Future<List<String>> quickSearch({required String query});
}
