import 'package:get_it/get_it.dart';
import 'package:recive/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/search_page/repos/search.repository.interface.dart';
import 'package:recive/features/search_page/repos/search.repository.local.dart';

import 'package:recive/router/navigation_service.dart';

GetIt locator = GetIt.instance;

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
  locator.registerLazySingleton<ISearchRepository>(
    () => SearchRepositoryLocal(),
  );
}

setupBlocs() {
  locator
    ..registerFactory(
      () => QuickSearchHeaderBloc(searchRepository: locator.get()),
    )
    ..registerFactory(
      () => CategoriesCubit(),
    )
    ..registerFactory(
      () => FeatureEventsCubit(),
    )
    ..registerFactory(
      () => NewsCubit(),
    );
}
