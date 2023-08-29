import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:open_weather_client/services/open_weather_api_service.dart';
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

import 'package:recive/router/navigation_service.dart';

import 'package:ferry/ferry.dart';
// import 'package:hive/hive.dart';
// *** If using flutter ***
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ferry_hive_store/ferry_hive_store.dart' as qqlStore;

GetIt locator = GetIt.instance;

Future<Client> initClient({
  required FlutterSecureStorage storage,
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
    headerKey: 'apiKey',
    getToken: () async {
      final accessToken = await storage.read(key: LoginCubit.accessTokenKey);
      if (kDebugMode) {
        print(
            "_________________| accessToken ${DateTime.now()} --> ${accessToken}");
      }
      return accessToken;
      //  return 'Bearer ${accessToken}';
    },
  );

  final httpLink = HttpLink(
    'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql',
    // defaultHeaders: {
    //   'apiKey':
    //       '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
    // },
  );

  final Link link = Link.from([authLink, httpLink]);
  final client = Client(
    link: link,
    cache: cache,
  );

  return client;
}

// final link = HttpLink(
//   'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql',
//   defaultHeaders: {
//     'apiKey':
//         '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
//   },
// );

// final client = Client(link: link);

setupNavigation() {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  locator.registerSingleton<FlutterSecureStorage>(storage);
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

setupRepositories() async {
  final c = await initClient(
    storage: locator.get(),
  );
  locator.registerLazySingleton<Client>(
    () => c,
  );
  OpenWeather openWeather = OpenWeather(
    apiKey: '8af110219c55ac7762ec012dfc20f17a',
  );
  locator
    ..registerSingleton<OpenWeather>(openWeather)
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

setupBlocs() {
  locator
    ..registerFactory(
      () => LoginCubit(storage: locator.get()),
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
