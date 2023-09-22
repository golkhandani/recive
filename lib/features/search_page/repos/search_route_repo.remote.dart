import 'dart:io';

import 'package:recive/domain/graphql/__generated__/get_arts.req.gql.dart';
import 'package:recive/domain/graphql/__generated__/get_trips.req.gql.dart';
import 'package:recive/features/package_page/models/art_route_model.dart';
import 'package:recive/features/package_page/repos/art_route_repo.remote.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';
import 'package:recive/features/search_page/repos/search_route_repo.interface.dart';
import 'package:recive/ioc/realm_gql_client.dart';

class GQLSearchRouteRepo extends ISearchRouteRepo
    implements IQuickSearchRepository {
  final RealmGqlClient client;

  GQLSearchRouteRepo({
    required this.client,
  });

  @override
  Future<List<ArtRouteAbstractModel>> search({
    required int limit,
    required String query,
    required double? distanceFilter,
    required ArtRouteAbstractModel? lastItem,
  }) async {
    final featuredEventRequest = GGetTripsReq((b) {
      if (query.isNotEmpty) {
        b.vars.query.tags_in.add(query);
      }
      if (lastItem != null) {
        b.vars.query.G_id_gt.value = lastItem.id;
      }
      b
        ..vars.limit = limit
        ..vars.query.trip.distance_lte = distanceFilter;

      return b;
    });

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
        .toSet()
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
