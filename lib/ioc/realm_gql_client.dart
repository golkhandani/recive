import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recive/ioc/dio_x.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:ferry/ferry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart' as qql_store;
import "package:dio/dio.dart" as dio;
import "package:gql_dio_link/gql_dio_link.dart";
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

// npm install -g get-graphql-schema
// get-graphql-schema -h 'apiKey=3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH' https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql > lib/schema.graphql

class RealmGqlClient {
  static const baseUrl = realmGqlBaseUrl;

  // ignore: unused_field
  final FlutterSecureStorage _secureStorage;
  final NavigationService _navigationService;
  final RealmApplicationService _realmApplicationService;
  final Box<dynamic> _cacheBox;
  late Client _client;

  RealmGqlClient({
    required FlutterSecureStorage secureStorage,
    required NavigationService navigationService,
    required RealmApplicationService realmApplicationService,
    required Box<dynamic> cacheBox,
  })  : _secureStorage = secureStorage,
        _navigationService = navigationService,
        _realmApplicationService = realmApplicationService,
        _cacheBox = cacheBox {
    _initClient();
  }

  void switchClient({bool isDeveloper = true}) {
    _initClient(isDeveloper: isDeveloper);
  }

  void resetCache() {
    _client.cache.clear();
  }

  final _dioClient = dio.Dio();

  void _initClient({bool isDeveloper = false}) {
    final store = qql_store.HiveStore(_cacheBox);

    final cache = Cache(store: store);

    final authInterceptor = AuthInterceptor(
      dio: _dioClient,
      realmApplicationService: _realmApplicationService,
      navigationService: _navigationService,
      isDeveloper: isDeveloper,
    );

    final Link dioLink = DioLink(
      baseUrl,
      client: _dioClient,
    );
    final logInterceptor = TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: false,
        printResponseHeaders: false,
        printResponseMessage: true,
        printRequestData: false,
        printResponseData: false,
      ),
    );
    _dioClient.interceptors.addAll([
      authInterceptor,
      logInterceptor,
    ]);

    final Link link = Link.from([dioLink]);
    final gqlClient = Client(
      link: link,
      cache: cache,
    );

    _client = gqlClient;
  }

  Future<OperationResponse<TData, TVars>> request<TData, TVars>(
      OperationRequest<TData, TVars> req) async {
    try {
      final res = await _client.request(req).asyncMap((res) async {
        if (kDebugMode) {
          print("_________________| graph ${res.hasErrors} ${res.dataSource}");
        }
        if (res.hasErrors) {
          await _handleErrors(res, req.hashCode);
        }

        return res;
      }).firstWhere(
        (data) => !data.loading || data.hasErrors,
      );

      return res;
    } catch (e) {
      if (kDebugMode) {
        print("______||| GQL request ERROR");
        print(e);
      }
      await _realmApplicationService.logout();
      await _navigationService.logoutTo(LoginScreen.name);
      rethrow;
    }
  }

  final sessionErrors = ['unauthorized', 'invalidSession'];

  Future _handleErrors<TData, TVars>(
      OperationResponse<TData, TVars> res, int key) async {
    final errors = [
      ...(res.graphqlErrors?.map((e) => e.message) ?? []).toList(),
      (res.linkException as ServerException).parsedResponse?.response['error']
    ].whereNotNull();
    if (kDebugMode) {
      print("______||| GQL ERROR");
      print(res.linkException);
      print(res.graphqlErrors);
      print(errors);
    }

    throw Exception(errors.join(' '));
  }
}
