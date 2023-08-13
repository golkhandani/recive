import 'package:get_it/get_it.dart';

import 'package:recive/repositories/fasting.repository.interface.dart';
import 'package:recive/repositories/fasting.repository.local.dart';
import 'package:recive/repositories/search.repository.interface.dart';
import 'package:recive/repositories/search.repository.local.dart';
import 'package:recive/repositories/user.repository.interface.dart';
import 'package:recive/repositories/user.repostory.local.dart';
import 'package:recive/router/navigation_service.dart';

import '../archived/featured_page/category_section/bloc/category_section_bloc.dart';
import '../archived/featured_page/greeting_header/bloc/greeting_header_bloc.dart';
import '../archived/featured_page/quick_search_header/bloc/quick_search_header_bloc.dart';
import '../archived/timer_page/bloc/fasting_bloc.dart';

GetIt locator = GetIt.instance;

setupNavigation() {
  locator.registerLazySingleton(
    () => NavigationService(
      rootNavigatorKey: rootNavigatorKey,
      dashboardNavigatorKey: dashboardNavigatorKey,
    ),
  );
}

setupRepositories() {
  locator
    ..registerLazySingleton<IUserRepository>(
      () => UserRepositoryLocal(),
    )
    ..registerLazySingleton<ISearchRepository>(
      () => SearchRepositoryLocal(),
    )
    ..registerLazySingleton<IFastingRepository>(
      () => FastingRepositoryLocal(),
    );
}

setupBlocs() {
  locator
    ..registerFactory(
      () => GreetingHeaderBloc(userRepository: locator.get()),
    )
    ..registerFactory(
      () => QuickSearchHeaderBloc(searchRepository: locator.get()),
    )
    ..registerFactory(
      () => CategorySectionBloc(),
    )
    ..registerFactory(
      () => FastingBloc(
        fastingRepository: locator.get(),
      ),
    );
}
