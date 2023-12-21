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
import 'package:recive/shared/extensions/theme_extensions.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/router_config.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/utils/theme.dart';
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
      child: BlocBuilder<ReciveThemeCubit, ReciveTheme>(
          bloc: themeBloc,
          builder: (context, reciveTheme) {
            final theme = ultravioletTheme.copyWith(
              colorScheme: reciveTheme.scheme,
              textTheme: getTextTheme(reciveTheme.scheme),
            );
            final statusBarItemBrightness =
                theme.colorScheme.brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light;

            final systemOverlayBrightness =
                theme.colorScheme.brightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: theme.colorScheme.secondaryContainer,
                statusBarIconBrightness: statusBarItemBrightness,
              ),
            );
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemOverlayBrightness,
              child: AppTheme(
                palette: AppThemePalette(
                  brightness: Brightness.light,

                  primary: const Color.fromARGB(255, 228, 162, 8),
                  onPrimary: const Color.fromARGB(255, 0, 0, 0),
                  primaryContainer: const Color.fromARGB(255, 152, 169, 202),
                  onPrimaryContainer: const Color.fromARGB(255, 0, 0, 0),

                  secondary: const Color.fromARGB(255, 85, 112, 199),
                  onSecondary: Colors.white,
                  secondaryContainer: const Color.fromARGB(255, 5, 13, 112),
                  onSecondaryContainer:
                      const Color.fromARGB(255, 255, 255, 255),

                  tertiary: const Color.fromARGB(255, 112, 142, 184),
                  onTertiary: const Color.fromARGB(255, 0, 0, 0),
                  tertiaryContainer: const Color.fromARGB(255, 152, 169, 207),
                  onTertiaryContainer: const Color.fromRGBO(255, 255, 255, 1),

                  error: Colors.red,
                  onError: Colors.white,
                  errorContainer: const Color.fromRGBO(141, 8, 41, 1),
                  onErrorContainer: Colors.white,

                  success: Colors.green,
                  onSuccess: Colors.white,
                  successContainer: const Color.fromRGBO(8, 141, 10, 1),
                  onSuccessContainer: Colors.white,

                  background:
                      const Color.fromARGB(255, 255, 255, 255), // Set to white
                  onBackground: const Color.fromRGBO(0, 0, 0, 1),
                  highlight: const Color.fromRGBO(0, 0, 0, 1),
                  onHighlight: const Color.fromRGBO(255, 255, 255, 1),

                  shadow: const Color.fromRGBO(124, 128, 155, 0.5),
                  surface: const Color.fromRGBO(0, 0, 0, 1),
                  onSurface: const Color.fromRGBO(255, 255, 255, 1),

                  navBackground: const Color.fromARGB(255, 122, 146, 225),
                  onNavBackground: const Color.fromARGB(255, 255, 255, 255),
                  onNavUnselected: const Color.fromARGB(255, 0, 0, 0),
                  onNavSelected: const Color.fromARGB(255, 255, 255, 255),

                  tabBarSelected: const Color.fromARGB(255, 5, 13, 112),
                  onTabBarSelected: const Color.fromARGB(255, 255, 255, 255),
                  tabBarUnselected: const Color.fromARGB(255, 126, 145, 206),
                  onTabBarUnselected: const Color.fromARGB(255, 0, 0, 0),

                  textFieldBackground: const Color.fromARGB(255, 5, 13, 112),
                  onTextFieldBackground: Colors.white,
                ),
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
                    theme: theme,
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
