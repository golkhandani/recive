import 'dart:async';
import 'dart:developer';

import 'package:art_for_all/core/ioc/device_secure_storage.dart';
import 'package:art_for_all/core/ioc/device_shared_storage.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/ioc/i_categories_repository.dart';
import 'package:art_for_all/core/ioc/i_event_repository.dart';
import 'package:art_for_all/core/ioc/i_news_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/environment.dart';
import 'package:art_for_all/modules/detail_art_screen/detail_art_bloc.dart';
import 'package:art_for_all/modules/featured_art_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/auth_screen/auth_bloc.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_bloc.dart';
import 'package:art_for_all/modules/profile_screen/profile_bloc.dart';
import 'package:art_for_all/modules/splash_screen/splash_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

GetIt locator = GetIt.instance;

class Logger {
  static void info(String message) {
    unawaited(() {
      Sentry.captureMessage(
        message,
      );
    }());
    log(message);
    debugPrint(message);
  }

  static void debug(String message) {
    unawaited(() {
      Sentry.captureMessage(message, level: SentryLevel.debug);
    }());
    log(message);
    debugPrint(message);
  }

  static void warn(String message, dynamic err, dynamic stack) {
    unawaited(() {
      Sentry.captureMessage(message, level: SentryLevel.warning);
    }());
    log(message, error: err, stackTrace: stack);
    debugPrint("$message $err");
  }

  static void error(String message, dynamic err, dynamic stack) {
    unawaited(() {
      Sentry.captureException(
        err,
        stackTrace: stack,
      );
    }());
    log(message, error: err, stackTrace: stack);
    debugPrint("$message $err");
  }
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
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  final ISecureStorage secureStorage = DeviceSecureStorage();

  final ISharedStorage sharedStorage = await DeviceSharedStorage.getInstance();

  locator.registerSingleton<ISecureStorage>(secureStorage);

  locator.registerSingleton<ISharedStorage>(sharedStorage);
}

Future setupRepositories() async {
  locator.registerSingleton<IArtRepository>(MockArtRepository());
  locator.registerSingleton<INewsRepository>(MockNewsRepository());
  locator.registerSingleton<ICategoryRepository>(MockCategoryRepository());
  locator.registerSingleton<IArtistRepository>(MockArtistRepository());
  locator.registerSingleton<IEventRepository>(MockEventRepository());
}

Future setupServices() async {
  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseKey,
  );
  final supabase = Supabase.instance.client;

  locator.registerLazySingleton<SupabaseClient>(() => supabase);
  locator.registerLazySingleton<IUserService>(
    () => SupabaseUserService(
      supabase: locator.get(),
      secureStorage: locator.get(),
      sharedStorage: locator.get(),
    ),
  );
}

Future setupBloc() async {
  final themeName = await locator.get<ISharedStorage>().read(key: ThemeCubit.themeStoreKey);
  final theme = ThemeCubitState.values.firstWhereOrNull((val) => val.name == themeName);
  locator.registerFactory(
    () => ThemeCubit(
      sharedStorage: locator.get(),
      initialValue: theme ?? ThemeCubitState.blue,
    ),
  );

  locator.registerFactory<SplashBloc>(
    () => SplashBloc(
      secureStorage: locator.get(),
      sharedPreferences: locator.get(),
      userService: locator.get(),
    ),
  );

  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      authService: locator.get(),
      bannerService: locator.get(),
    ),
  );

  locator.registerFactory<FeaturedArtBloc>(
    () => FeaturedArtBloc(
      secureStorage: locator.get(),
      sharedPreferences: locator.get(),
      artRepository: locator.get(),
      newsRepository: locator.get(),
      categoryRepository: locator.get(),
      artistRepository: locator.get(),
      eventRepository: locator.get(),
    ),
  );

  locator.registerFactory<MapArtBloc>(
    () => MapArtBloc(
        secureStorage: locator.get(),
        sharedPreferences: locator.get(),
        artRepository: locator.get()),
  );

  locator.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      userService: locator.get(),
      bannerService: locator.get(),
    ),
  );
  locator.registerFactory<DetailArtBloc>(
    () => DetailArtBloc(
      secureStorage: locator.get(),
      sharedStorage: locator.get(),
      artRepository: locator.get(),
    ),
  );
}
