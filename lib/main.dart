import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import 'package:recive/firebase_options.dart';
import 'package:recive/modules/bookmarks_page/cubits/bookmarks_cubit.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/introduction_page/splash_screen.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/router_config.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/utils/theme_cubit.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

void main() {
  runZonedGuarded(() async {
    PlatformDispatcher.instance.onError = (error, stack) {
      if (kDebugMode) {
        print(stack.toString());
        print(error);
      }

      return true;
    };
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // await locationService.requestService(onGrantedPermission: () => {});

    await setupNavigation();
    await setupStorage();
    await setupGraphQL();
    await setupRepositories();
    await setupBlocs();

    const initRoute = '/${SplashScreen.name}';
    // GoRouter configuration
    final goRouter = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: initRoute,
      navigatorKey: rootNavigatorKey,
      routes: [
        ...initRoutes,
        ...dashboardRoutes,
        ...authRoutes,
        ...extraRoutes,
      ],
    );
    FlutterNativeSplash.remove();

    return runApp(Application(goRouter: goRouter));
  }, (error, stack) {
    if (kDebugMode) {
      print(stack.toString());
      print(error);
    }
  });
}

class Application extends StatelessWidget {
  const Application({super.key, required this.goRouter});
  final GoRouter goRouter;

  @override
  Widget build(BuildContext context) {
    final themeBloc = locator.get<ReciveThemeCubit>();
    final bookmarksBloc = locator.get<BookmarksCubit>();
    final categoriesBloc = locator.get<CategoriesCubit>();
    final child = MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeBloc),
        BlocProvider.value(value: bookmarksBloc),
        BlocProvider.value(value: categoriesBloc),
      ],
      child: BlocBuilder<ReciveThemeCubit, AppPaletteType>(
          bloc: themeBloc,
          builder: (context, reciveTheme) {
            final statusBarItemBrightness =
                reciveTheme.colorPalette.brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light;

            final systemOverlayBrightness =
                reciveTheme.colorPalette.brightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: reciveTheme.colorPalette.secondaryContainer,
                statusBarIconBrightness: statusBarItemBrightness,
              ),
            );
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemOverlayBrightness,
              child: AppTheme(
                palette: reciveTheme.colorPalette,
                child: ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: MaterialApp.router(
                    scrollBehavior: const MaterialScrollBehavior().copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                        PointerDeviceKind.stylus,
                        PointerDeviceKind.unknown
                      },
                    ),
                    routerConfig: goRouter,
                    builder: (context, child) => Container(
                      constraints:
                          const BoxConstraints(maxHeight: 900, maxWidth: 600),
                      child: child!,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
    final hookedBloc = HookedBlocConfigProvider(
      injector: () => locator.get,
      builderCondition: (state) => state != null, // Global build condition
      listenerCondition: (state) => state != null, // Global listen condition
      child: child,
    );

    return hookedBloc;
  }
}
