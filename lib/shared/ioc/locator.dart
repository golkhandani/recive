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

import 'package:recive/core/components/flutter_map_card_container/cubit/map_control_cubit.dart';
import 'package:recive/core/components/flutter_map_card_container/flutter_map_cached_tile_provider.dart';
import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/domain/client/realm_gql_client.dart';
import 'package:recive/modules/bookmarks/cubits/bookmarks_cubit.dart';
import 'package:recive/modules/bookmarks/models/bookmark_hive_object.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/repos/categories_repo.interface.dart';
import 'package:recive/modules/categories_page/repos/categories_repo.remote.dart';
import 'package:recive/modules/featured_page/cubits/featured_cubit.dart';
import 'package:recive/modules/featured_page/repos/arts_repo.interface.dart';
import 'package:recive/modules/featured_page/repos/arts_repo.remote.dart';
import 'package:recive/modules/introduction_page/cubits/setting_loader_cubit.dart';
import 'package:recive/modules/login_page/cubits/login_cubit.dart';
import 'package:recive/modules/near_me_page/cubits/art_detail_cubit.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/repos/nearby_arts_repo.interface.dart';
import 'package:recive/modules/near_me_page/repos/nearby_arts_repo.remote.dart';
import 'package:recive/modules/news_page/cubits/news_cubit.dart';
import 'package:recive/modules/package_page/cubits/packages_cubit.dart';
import 'package:recive/modules/package_page/repos/art_route_repo.interface.dart';
import 'package:recive/modules/package_page/repos/art_route_repo.remote.dart';
import 'package:recive/modules/search_page/cubits/search_cubit.dart';
import 'package:recive/modules/search_page/repos/search_route_repo.interface.dart';
import 'package:recive/modules/search_page/repos/search_route_repo.remote.dart';
import 'package:recive/shared/constants/key_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/services/geo_location_service.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/services/realm_service.dart';
import 'package:recive/shared/services/routing_machine_service.dart';
import 'package:recive/shared/utils/recive_theme_adapter.dart';
import 'package:recive/shared/utils/share_service.dart';
import 'package:recive/shared/utils/theme_cubit.dart';

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
  locator.registerLazySingleton(
    () => ShareService(navigationService: locator.get()),
  );
}

Future setupStorage() async {
  // START REGISTER Hive REQUEST CACHE STORE
  Hive.init(StoreBoxConstant.hiveStoreFolderName);
  Hive.registerAdapter(AppPaletteTypeAdapter());
  Hive.registerAdapter(BookmarkHiveObjectAdapter());

  await Hive.initFlutter();
  final box = await Hive.openBox(StoreBoxConstant.hiveStoreGqlBoxName);
  locator.registerSingleton<Box>(box);

  final themeBox = await Hive.openBox<AppPaletteType>(
    StoreBoxConstant.hiveStoreThemeBoxName,
  );
  final theme = themeBox.get(ReciveThemeCubit.themeStoreKey);
  locator.registerSingleton<Box<AppPaletteType>>(themeBox);
  locator.registerFactory(
    () => ReciveThemeCubit(
      box: locator.get(),
      initalValue: theme,
    ),
  );

  final favouriteBox = await Hive.openBox<BookmarkHiveObject>(StoreBoxConstant.hiveStoreBookmarksBoxName);
  locator.registerSingleton<Box<BookmarkHiveObject>>(favouriteBox);

  final introductionBox = await Hive.openBox<bool>(
    StoreBoxConstant.hiveStoreIntroductionBoxName,
  );
  locator.registerSingleton<Box<bool>>(introductionBox);
  // END REGISTER Hive REQUEST CACHE STORE

  // START REGISTER HydratedBloc CACHE STORE
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await path_provider.getTemporaryDirectory(),
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
    return FlutterMapCachedTileProvider();
  });

  locator.registerSingleton(locationService);
}

Future setupGraphQL() async {
  final googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: GoogleConstant.gSignInScopes,
    serverClientId: GoogleConstant.gSignInServerCid,
  );
  locator.registerSingleton<GoogleSignIn>(googleSignIn);

  final appConfig = AppConfiguration(
    ApiConstant.realmAppId,
    baseUrl: Uri.parse(ApiConstant.realmBaseUrl),
    httpClient: HttpClient(),
    maxConnectionTimeout: const Duration(seconds: ApiConstant.realmTimeout),
    defaultRequestTimeout: const Duration(seconds: ApiConstant.realmTimeout),
    localAppVersion: ApiConstant.realmVersion,
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

  final osrmManager = OSRMManager.custom(
    server: "https://routing.openstreetmap.de",
    roadType: RoadType.foot,
  );
  locator.registerLazySingleton(
    () => RoutingMachineService(osrmManager: osrmManager),
  );
}

Future setupRepositories() async {
  locator
    ..registerSingleton<OpenWeather>(
      OpenWeather(apiKey: ApiConstant.openWeatherKey),
    )
    ..registerLazySingleton<IArtRepo>(
      () => GQLArtRepo(
        client: locator.get(),
      ),
    )
    ..registerLazySingleton<INearbyArtRepo>(
      () => GQLNearbyArtRepo(
        client: locator.get(),
      ),
    )
    ..registerLazySingleton<ISearchRouteRepo>(
      () => GQLSearchRouteRepo(
        client: locator.get(),
      ),
    )
    ..registerLazySingleton<IArtRouteRepo>(
      () => GQLArtRouteRepo(
        client: locator.get(),
        rms: locator.get(),
      ),
    )
    ..registerLazySingleton<ICategoryRepo>(
      () => GQLCategoryRepo(client: locator.get()),
    );
}

Future setupBlocs() async {
  locator
    ..registerFactory(
      () => SettingLoaderCubit(
        applicationService: locator.get(),
        storage: locator.get(),
        introductionBox: locator.get(),
        locationService: locator.get(),
      ),
    )
    ..registerFactory(
      () => LoginCubit(
        storage: locator.get(),
        introBox: locator.get(),
        themeBox: locator.get(),
        bookmarkBox: locator.get(),
        applicationService: locator.get(),
        googleSignIn: locator.get(),
      ),
    )
    ..registerFactory(
      () => CategoriesCubit(
        categoryRepo: locator.get(),
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => FeaturedCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => NewsCubit(),
    )
    ..registerFactory(
      () => MapControlCubit(),
    )
    ..registerFactory(
      () => NearbyCubit(
        repo: locator.get(),
      ),
    )
    ..registerFactory(
      () => ArtDetailCubit(
        repo: locator.get(),
        bookmarkBox: locator.get(),
      ),
    )
    ..registerFactory(
      () => SearchCubit(
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
    )
    ..registerFactory(
      () => BookmarksCubit(
        repo: locator.get(),
        bookmarkBox: locator.get(),
        applicationService: locator.get(),
      ),
    );
}
