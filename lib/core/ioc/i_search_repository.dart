import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:faker/faker.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ISearchRepository {
  Future<List<SearchableAbstractModel>> searchByQuery({
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  });

  Future<List<String>> getCommonKeyboards();

  Future<List<SearchableAbstractModel>> searchByCoordinate(LatLng? coordinates);
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

  final SupabaseClient supabase;
  final faker = Faker();

  MockSearchRepository({
    required this.supabase,
  });

  @override
  Future<List<String>> getCommonKeyboards() async {
    return Future.value(keywords);
  }

  late final List<SearchableAbstractModel> search = List.generate(200, (index) {
    return SearchableAbstractModel(
      id: faker.guid.guid(),
      title: faker.lorem.words(2).join(' '),
      imageUrl: 'https://picsum.photos/800/1000?random=${faker.randomGenerator.integer(200)}',
      searchType: SearchType.values[faker.randomGenerator.integer(SearchType.values.length)],
      tags: List.generate(4, (i) => faker.food.cuisine()),
      geoLocation: LatLng(
        49.2827 + (faker.randomGenerator.integer(100) / 1000),
        -123.1207 + (faker.randomGenerator.integer(100) / 1000),
      ),
    );
  });

  @override
  Future<List<SearchableAbstractModel>> searchByQuery({
    required String query,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  }) async {
    final rpc = await supabase.rpc('get_tag_artworks', params: {
          'input_query': query.split(' ').join('&'),
          'input_limit': 20,
        }) as ArrayRes ??
        [];

    return rpc.map((r) {
      return SearchableAbstractModel(
        id: r['id'],
        title: r['title'],
        imageUrl:
            r['media']['id'] == null ? MediaModel.artistPlaceholder.url : r['media']['url'],
        searchType: SearchTypeConverter.fromString(r['type']),
        tags: (r['tags'] as ArrayRes ?? []).map((t) => t.toString()).toList(),
        geoLocation: LatLng(r['lat'] ?? 0, r['lng'] ?? 0),
      );
    }).toList();
  }

  @override
  Future<List<SearchableAbstractModel>> searchByCoordinate(LatLng? coordinates) async {
    /// START TEST
    final rpc = await supabase.rpc('get_nearby_artworks', params: {
          'input_lat': coordinates?.latitude ?? 49.2827,
          'input_lng': coordinates?.longitude ?? -123.1207,
          'input_query': null,
          'input_limit': 20,
        }) as ArrayRes ??
        [];

    return rpc.map((r) {
      return SearchableAbstractModel(
        id: r['id'],
        title: r['title'],
        imageUrl:
            r['media']['id'] == null ? MediaModel.artistPlaceholder.url : r['media']['url'],
        searchType: SearchTypeConverter.fromString(r['type']),
        tags: (r['tags'] as ArrayRes ?? []).map((t) => t.toString()).toList(),
        geoLocation: LatLng(r['lat'] ?? 0, r['lng'] ?? 0),
      );
    }).toList();
  }
}
