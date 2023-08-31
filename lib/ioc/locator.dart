import 'package:flutter/foundation.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql/client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:open_weather_client/services/open_weather_api_service.dart';
import 'package:realm/realm.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/featured_page/repos/events_repo.gql.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_event_detail_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/features/near_me_page/repos/nearby_events_repo.gql.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/features/search_page/repos/search_events_repo.gql.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recive/ioc/realm_service.dart';

import 'package:recive/router/navigation_service.dart';

import 'package:ferry/ferry.dart';
// import 'package:hive/hive.dart';
// *** If using flutter ***
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ferry_hive_store/ferry_hive_store.dart' as qqlStore;
import 'package:path_provider/path_provider.dart';

GetIt locator = GetIt.instance;

Future<Client> initClient({
  required FlutterSecureStorage storage,
  required NavigationService navigationService,
}) async {
  Hive.init('hive_data');

  // OR, if using flutter
  await Hive.initFlutter();

  final box = await Hive.openBox("graphql");

  final store = qqlStore.HiveStore(box);

  final cache = Cache(store: store);

  // npm install -g get-graphql-schema
  // get-graphql-schema -h 'apiKey=3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH' https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql > lib/schema.graphql

  final authLink = AuthLink(
    getToken: () async {
      final accessToken = await storage.read(
        key: RealmApplicationService.accessTokenKey,
      );
      print(
          "_________________| accessToken ${DateTime.now()} --> ${accessToken}");
      return 'Bearer ${accessToken}';
    },
  );

  final httpLink = HttpLink(
    'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql',
  );

  final Link link = Link.from([authLink, httpLink]);
  final client = Client(
    link: link,
    cache: cache,
  );

  return client;
}

Future setupNavigation() async {
  locator.registerLazySingleton(
    () => NavigationService(
      rootNavigatorKey: rootNavigatorKey,
      homeNavigatorKey: homeNavigatorKey,
      nearMeNavigatorKey: nearMeNavigatorKey,
      searchNavigatorKey: searchNavigatorKey,
      profileNavigatorKey: profileNavigatorKey,
    ),
  );
}

Future setupStorage() async {
  await FlutterMapTileCaching.initialise();
  await FMTC.instance('FlutterMapTileStore').manage.createAsync();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await HydratedBloc.storage.clear();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  locator.registerSingleton<FlutterSecureStorage>(storage);

  locator.registerSingleton<GoogleSignIn>(googleSignIn);
  locator.registerLazySingleton<RealmApplicationService>(
    () => RealmApplicationService(
      storage: locator.get(),
    ),
  );
}

Future setupGraphQL() async {
  final client = await initClient(
    storage: locator.get(),
    navigationService: locator.get(),
  );
  locator.registerLazySingleton<Client>(
    () => client,
  );
}

Future setupRepositories() async {
  locator
    ..registerSingleton<OpenWeather>(
      OpenWeather(
        apiKey: '8af110219c55ac7762ec012dfc20f17a',
      ),
    )
    ..registerLazySingleton<IEventRepo>(
      () => GQLEventRepo(
        client: locator.get(),
      ),
    )
    ..registerLazySingleton<INearbyEventRepo>(
      () => GQLNearbyEventRepo(
        client: locator.get(),
      ),
    )
    ..registerLazySingleton<ISearchEventRepo>(
      () => GQLSearchEventRepo(
        client: locator.get(),
      ),
    );
}

Future setupBlocs() async {
  locator
    ..registerFactory(
      () => LoginCubit(
        storage: locator.get(),
        applicationService: locator.get(),
        googleSignIn: locator.get(),
      ),
    )
    ..registerFactory(
      () => CategoriesCubit(),
    )
    ..registerFactory(
      () => FeatureEventsCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => NewsCubit(),
    )
    ..registerFactory(
      () => NearbyEventsCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => NearbyEventDetailCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => SearchEventsCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => QuickSearchHeaderBloc(searchRepository: locator.get()),
    );
}
