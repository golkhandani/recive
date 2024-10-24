import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:faker/faker.dart';

abstract class ISearchRepository {
  Future<List<SearchAbstractModel>> searchByQuery({
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
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

  late final List<SearchAbstractModel> search = List.generate(50, (index) {
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
  }) async {
    await Future.delayed(kLoadingDuration);
    return search;
  }
}
