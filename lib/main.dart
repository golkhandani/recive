import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/login_page/splash_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/router/router_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recive/utils/theme.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FlutterMapTileCaching.initialise();
  await FMTC.instance('FlutterMapTileStore').manage.createAsync();
  // GoRouter configuration
  final goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/${SplashScreen.name}',
    navigatorKey: rootNavigatorKey,
    routes: [
      ...initRoutes,
      ...dashboardRoutes,
      ...authRoutes,
      ...extraRoutes,
    ],
  );
  setupNavigation();
  await setupRepositories();
  setupBlocs();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await HydratedBloc.storage.clear();
  FlutterNativeSplash.remove();
  // timeDilation = 1.2;
  runApp(Application(goRouter: goRouter));
}

class Application extends StatelessWidget {
  const Application({super.key, required this.goRouter});
  final GoRouter goRouter;

  @override
  Widget build(BuildContext context) {
    final theme = ultravioletTheme;
    final child = ScrollConfiguration(
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
        theme: theme.copyWith(
          textTheme: GoogleFonts.nunitoSansTextTheme(theme.textTheme),
        ),
        builder: (context, child) => Container(
          constraints: const BoxConstraints(maxHeight: 900, maxWidth: 600),
          child: child!,
        ),
      ),
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
