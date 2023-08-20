import 'package:recive/features/search_page/repos/search.repository.interface.dart';

final List<String> list = List.generate(20, (index) => "Text $index");

class SearchRepositoryLocal extends ISearchRepository {
  @override
  Future<List<String>> quickSearch({required String query}) async {
    var filteredList = <String>[];

    filteredList = list
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    await Future.delayed(const Duration(seconds: 1));
    return filteredList;
  }
}
