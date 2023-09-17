abstract class IQuickSearchRepository {
  Future<List<String>> quickSearch({required String query});
}
