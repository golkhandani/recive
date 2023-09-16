import 'dart:io';

import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/repos/events_repo.remote.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLSearchEventRepo extends ISearchEventRepo implements ISearchRepository {
  final RealmGqlClient client;

  GQLSearchEventRepo({
    required this.client,
  });

  @override
  Future<List<ArtModel>> search({
    required int limit,
    required String query,
  }) async {
    final featuredEventRequest = GGetArtsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.tags_in.add(query),
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.art_items;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = events
        .map((e) {
          if (e == null) {
            return null;
          }
          final v = e.location?.venue;
          final s = e.source;
          return gqlArtsToArtModel(e.G_id!.value, e, v, s);
        })
        .whereType<ArtModel>()
        .toList();

    return convertedData;
  }

  @override
  Future<List<String>> quickSearch({required String query}) async {
    var filteredList = await keywords(limit: 10);

    filteredList = filteredList
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList;
  }

  @override
  Future<List<String>> keywords({required int limit}) async {
    final featuredEventRequest = GGetArtsReq(
      (b) => b..vars.limit = limit,
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.art_items;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = events
        .map((e) {
          if (e == null) {
            return null;
          }
          return e.tags?.toList() ?? [];
        })
        .expand((t) => t!)
        .whereType<String>()
        .toList();

    return convertedData;
  }
}
