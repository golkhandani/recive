import 'package:recive/models/recive.model.dart';
import 'package:recive/repositories/search.repository.interface.dart';

import 'package:recive/utils/sleep.dart';

final List<String> list = List.generate(20, (index) => "Text $index");

class SearchRepositoryLocal extends ISearchRepository {
  @override
  Future<List<Recive>> search() async {
    await sleep;
    return [];
  }

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
