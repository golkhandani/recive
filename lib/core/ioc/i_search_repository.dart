import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:faker/faker.dart';

abstract class ISearchRepository {
  Future<List<SearchAbstractModel>> searchByQuery({
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  });

  Future<List<String>> getCommonKeyboards();
}

class MockSearchRepository extends ISearchRepository {
  List<String> keywords = [
    'Contemporary',
    'Abstract',
    'Fine',
    'Modern',
    'Exhibitions',
    'Digital',
    'Installations',
    'Street',
    'Classical',
    'Galleries'
  ];

  @override
  Future<List<String>> getCommonKeyboards() async {
    return Future.value(keywords);
  }

  final faker = Faker();

  late final List<SearchAbstractModel> search = List.generate(200, (index) {
    return SearchAbstractModel(
      id: faker.guid.guid(),
      title: faker.lorem.words(2).join(' '),
      imageUrl: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
      searchType: SearchType.values[faker.randomGenerator.integer(SearchType.values.length)],
      tags: List.generate(4, (i) => faker.food.cuisine()),
    );
  });

  @override
  Future<List<SearchAbstractModel>> searchByQuery({
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  }) async {
    await Future.delayed(kDebounceDuration);
    return search.where((s) {
      if (filtersData.art && s.searchType == SearchType.art) {
        return true;
      }

      if (filtersData.artists && s.searchType == SearchType.artist) {
        return true;
      }

      if (filtersData.communities && s.searchType == SearchType.community) {
        return true;
      }

      if (filtersData.events && s.searchType == SearchType.event) {
        return true;
      }

      if (filtersData.news && s.searchType == SearchType.news) {
        return true;
      }

      return false;
    }).toList();
  }
}
