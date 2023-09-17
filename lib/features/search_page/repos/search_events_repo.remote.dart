import 'dart:io';

import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_trips.req.gql.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/repos/package_events_repo.remote.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLSearchEventRepo extends ISearchEventRepo
    implements IQuickSearchRepository {
  final RealmGqlClient client;

  GQLSearchEventRepo({
    required this.client,
  });

  @override
  Future<List<PackageAbstract>> search({
    required int limit,
    required String query,
  }) async {
    final featuredEventRequest = GGetTripsReq(
      (b) => b
        ..vars.limit = limit
        ..vars.query.tags_in.add(query),
    );

    final data = await client.request(featuredEventRequest);
    final events = data.data?.trip_items;

    if (events == null) {
      throw const HttpException('Data is empty');
    }

    final convertedData = data.data?.trip_items.map((item) {
          return gqlTripsToPackageAbstract(item);
        }).toList() ??
        [];

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
