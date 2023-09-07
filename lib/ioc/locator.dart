import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:open_weather_client/services/open_weather_api_service.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:realm/realm.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/featured_page/repos/events_repo.remote.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_event_detail_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/features/near_me_page/repos/nearby_events_repo.remote.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/package_page/cubits/packages_cubit.dart';
import 'package:recive/features/package_page/repos/package_event_repo.interface.dart';
import 'package:recive/features/package_page/repos/package_events_repo.remote.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/features/search_page/repos/search_events_repo.remote.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/ioc/recive_theme_adapter.dart';
import 'package:recive/ioc/routing_machine_service.dart';
import 'package:recive/key_constants.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/utils/theme_cubit.dart';

GetIt locator = GetIt.instance;

extension LoggerLocator on GetIt {
  Logger get logger => GetIt.instance.get<Logger>();
}

Future setupNavigation() async {
  final logger = Logger();
  locator.registerSingleton(logger);
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
  // START REGISTER Hive REQUEST CACHE STORE
  Hive.init(hiveStoreFolderName);
  Hive.registerAdapter(ReciveThemeAdapter());

  await Hive.initFlutter();
  final box = await Hive.openBox(hiveStoreGqlBoxName);
  locator.registerSingleton<Box>(box);

  final themeBox = await Hive.openBox<ReciveTheme>(hiveStoreThemeBoxName);
  final theme = themeBox.get(ReciveThemeCubit.themeStoreKey);
  locator.registerSingleton<Box<ReciveTheme>>(themeBox);
  locator.registerLazySingleton(
    () => ReciveThemeCubit(
      box: locator.get(),
      initalValue: theme,
    ),
  );
  // END REGISTER Hive REQUEST CACHE STORE

  // START REGISTER HydratedBloc CACHE STORE
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await path_provider.getTemporaryDirectory(),
  );
  await HydratedBloc.storage.clear();
  locator.registerSingleton(HydratedBloc);
  // END REGISTER HydratedBloc CACHE STORE

  // START REGISTER flutterSecureStorage STORE
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  final flutterSecureStorage = FlutterSecureStorage(
    aOptions: getAndroidOptions(),
  );
  locator.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
  // START REGISTER flutterSecureStorage STORE

  locator.registerSingletonAsync<TileProvider>(() async {
    // await FlutterMapTileCaching.initialise();
    // await FMTC.instance('FlutterMapTileStore').manage.createAsync();
    // FMTC.instance('FlutterMapTileStore').getTileProvider(),
    return NetworkTileProvider();
  });
}

Future setupGraphQL() async {
  final googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: gSignInScopes,
    serverClientId: gSignInServerCid,
  );
  locator.registerSingleton<GoogleSignIn>(googleSignIn);

  final appConfig = AppConfiguration(
    realmAppId,
    baseUrl: Uri.parse(realmBaseUrl),
    httpClient: HttpClient(),
    maxConnectionTimeout: const Duration(seconds: realmTimeout),
    defaultRequestTimeout: const Duration(seconds: realmTimeout),
    localAppVersion: realmVersion,
  );
  final app = App(appConfig);

  locator.registerLazySingleton<RealmApplicationService>(
    () => RealmApplicationService(
      app: app,
      storage: locator.get(),
      navigationService: locator.get(),
    ),
  );

  final realmGraphqlClient = RealmGqlClient(
    cacheBox: locator.get(),
    secureStorage: locator.get(),
    realmApplicationService: locator.get(),
    navigationService: locator.get(),
  );
  locator.registerSingleton<RealmGqlClient>(realmGraphqlClient);

  final osrmManager = OSRMManager();
  locator.registerLazySingleton(
    () => RoutingMachineService(osrmManager: osrmManager),
  );
}

Future setupRepositories() async {
  locator
    ..registerSingleton<OpenWeather>(
      OpenWeather(apiKey: openWeatherKey),
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
    )
    ..registerLazySingleton<IPackageEventRepo>(
      () => GQLPackageEventRepo(
        client: locator.get(),
        rms: locator.get(),
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
        eventRepo: locator.get(),
      ),
    )
    ..registerFactory(
      () => SearchEventsCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => QuickSearchHeaderBloc(
        searchRepository: locator.get(),
      ),
    )
    ..registerFactory(
      () => PackagesCubit(
        repo: locator.get(),
      ),
    );
}
