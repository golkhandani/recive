import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:ferry/ferry.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart' as qql_store;

// npm install -g get-graphql-schema
// get-graphql-schema -h 'apiKey=3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH' https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql > lib/schema.graphql

class RealmGqlClient {
  static const baseUrl = realmGqlBaseUrl;

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

  void _initClient({bool isDeveloper = false}) {
    final store = qql_store.HiveStore(_cacheBox);

    final cache = Cache(store: store);

    final authLink = AuthLink(
      headerKey: isDeveloper ? 'apiKey' : 'authorization',
      getToken: () async {
        //  'apiKey' = '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH';
        String? token = _realmApplicationService.currentUser?.accessToken;
        if (kDebugMode) {
          print(
              "_________________| accessToken ${_realmApplicationService.isDeveloper} ${DateTime.now()}$token");
        }
        if (token == null || token.isEmpty) {
          await _realmApplicationService.updateToken();
          await _secureStorage.readAll();
          token = _realmApplicationService.currentUser?.accessToken;
        }
        if (token == null) {
          await _navigationService.navigateTo(LoginScreen.name);
          return '';
        }

        return isDeveloper ? token : 'Bearer $token';
      },
    );

    final httpLink = HttpLink(baseUrl);

    final Link link = Link.from([authLink, httpLink]);
    final client = Client(
      link: link,
      // cache: cache,
    );

    _client = client;
  }

  Future<OperationResponse<TData, TVars>> request<TData, TVars>(
      OperationRequest<TData, TVars> req) async {
    final res = await _client.request(req).map((data) {
      if (kDebugMode) {
        print(
            "_________________| request graph ${data.hasErrors} ${data.loading} ${data.dataSource}");
      }
      return data;
    }).firstWhere((data) => !data.loading || data.hasErrors);
    if (res.hasErrors) {
      _handleErrors(res);
    }
    return res;
  }

  _handleErrors<TData, TVars>(OperationResponse<TData, TVars> res) {
    if (kDebugMode) {
      print(res.linkException);
      print(res.graphqlErrors);
    }
  }
}
