import 'package:art_for_all/core/enums/data_tables.dart';
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
    required String? cursorId,
    required double? cursorRank,
    required int limit,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  });

  Future<List<String>> getCommonKeyboards();

  Future<List<SearchableAbstractModel>> searchByCoordinate({
    LatLng? coordinates,
    String? query,
    double? distance,
    String? categoryId,
    EntityType? type,
  });
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
    final count = await supabase.from('searchable').count().eq('publish_status', 'published');
    final rand = faker.randomGenerator.integer(count);
    final res = await supabase.from('searchable').select('''
            id,
            tags
    ''').eq('publish_status', 'published').range(rand, rand + 5) as ArrayRes ?? [];
    if (res.isEmpty) return keywords;
    final tags = <String>[];
    for (var r in res) {
      if (r['tags'] == null) continue;
      for (var t in r['tags']) {
        if (t != null) tags.add(t);
      }
    }
    return tags;
  }

  @override
  Future<List<SearchableAbstractModel>> searchByQuery({
    required String query,
    required String? cursorId,
    required double? cursorRank,
    required int limit,
    required SortType sortType,
    required SortOrderType sortOrderType,
    required SearchScreenFiltersData filtersData,
  }) async {
    final filters = [
      if (filtersData.art) "art",
      if (filtersData.artists) "artist",
      if (filtersData.events) "event",
      // TODO update it when others added to searchable
      if (filtersData.news) "art",
      if (filtersData.communities) "art",
    ];
    final rpc = await supabase.rpc(
          DataFunctions.acTextSearch.fnName,
          params: {
            'input_query': query.trim().split(' ').join('&'),
            'input_types': filters,
            'input_limit': limit,
            'input_cursor_rank': cursorRank,
            'input_cursor_ref_id': cursorId,
          },
        ) as ArrayRes ??
        [];
    return rpc.map((r) {
      return SearchableAbstractModel(
        id: r['id'],
        title: r['title'],
        rank: double.tryParse(r['rank'].toString()) ?? 0,
        imageUrl:
            r['media']['id'] == null ? MediaModel.artistPlaceholder.url : r['media']['url'],
        entityType: EntityTypeConverter.fromString(r['type']),
        tags: (r['tags'] as ArrayRes ?? []).map((t) => t.toString()).toList(),
        geoLocation: LatLng(r['lat'] ?? 0, r['lng'] ?? 0),
      );
    }).toList();
  }

  @override
  Future<List<SearchableAbstractModel>> searchByCoordinate({
    LatLng? coordinates,
    String? query,
    double? distance,
    String? categoryId,
    EntityType? type,
  }) async {
    /// START TEST
    final rpc = await supabase.rpc(
          DataFunctions.acNearbySearch.fnName,
          params: {
            'input_limit': 50,
            'input_lat': coordinates?.latitude ?? 49.2827,
            'input_lng': coordinates?.longitude ?? -123.1207,
            'input_query':
                (query?.isEmpty ?? true) ? null : query?.trim().split(' ').join('&'),
            'input_distance': distance,
            'input_category_id': categoryId,
            'input_type': type?.name,
          },
        ) as ArrayRes ??
        [];

    return rpc.map((r) {
      return SearchableAbstractModel(
        id: r['id'],
        title: r['title'],
        rank: r['rank'] ?? 1,
        imageUrl:
            r['media']['id'] == null ? MediaModel.artistPlaceholder.url : r['media']['url'],
        entityType: EntityTypeConverter.fromString(r['type']),
        tags: (r['tags'] as ArrayRes ?? []).map((t) => t.toString()).toList(),
        geoLocation: LatLng(r['lat'] ?? 0, r['lng'] ?? 0),
      );
    }).toList();
  }
}
