import 'package:get_it/get_it.dart';
import 'package:recive/features/featured/category_section/bloc/category_section_bloc.dart';
import 'package:recive/features/featured/greeting_header/bloc/greeting_header_bloc.dart';
import 'package:recive/features/featured/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/repositories/search.repository.interface.dart';
import 'package:recive/repositories/search.repository.local.dart';
import 'package:recive/repositories/user.repository.interface.dart';
import 'package:recive/repositories/user.repostory.local.dart';
import 'package:recive/router/navigation_service.dart';

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
    );
}
