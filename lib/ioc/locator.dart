import 'package:get_it/get_it.dart';
import 'package:open_weather_client/services/open_weather_api_service.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/featured_page/repos/events_repo.gql.dart';
import 'package:recive/features/near_me_page/cubits/near_by_event_detail_cubit.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/features/near_me_page/repos/nearby_events_repo.gql.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/repos/search_event_repo.interface.dart';
import 'package:recive/features/search_page/repos/search_events_repo.gql.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';

import 'package:recive/router/navigation_service.dart';

import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
// import 'package:hive/hive.dart';
// *** If using flutter ***
import 'package:hive_flutter/hive_flutter.dart';

GetIt locator = GetIt.instance;

Client initClient() {
  Hive.init('hive_data');
  // OR, if using flutter
  // await Hive.initFlutter();

  // final box = await Hive.openBox("graphql");

  // final store = HiveStore(box);

  // final cache = Cache(store: store);

  // npm install -g get-graphql-schema
  // get-graphql-schema -h 'apiKey=3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH' https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql > lib/schema.graphql

  final link = HttpLink(
    'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql',
    defaultHeaders: {
      'apiKey':
          '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
    },
  );

  final client = Client(
    link: link,
    // cache: cache,
  );

  return client;
}

final link = HttpLink(
  'https://us-east-1.aws.realm.mongodb.com/api/client/v2.0/app/suggesteventpath-mgnsw/graphql',
  defaultHeaders: {
    'apiKey':
        '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
  },
);

final client = Client(link: link);

setupNavigation() {
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

setupRepositories() {
  locator.registerLazySingleton<Client>(() => initClient());
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
