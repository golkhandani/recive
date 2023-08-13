import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/router/router_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recive/utils/theme.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // GoRouter configuration
  final goRouter = GoRouter(
    initialLocation: '/${DashboardScreen.name}',
    navigatorKey: rootNavigatorKey,
    routes: [
      ...initRoutes,
      ...dashboardRoutes,
      ...authRoutes,
      ...extraRoutes,
    ],
  );
  setupNavigation();
  setupRepositories();
  setupBlocs();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await HydratedBloc.storage.clear();
  FlutterNativeSplash.remove();
  runApp(Application(goRouter: goRouter));
}

class Application extends StatelessWidget {
  const Application({super.key, required this.goRouter});
  final GoRouter goRouter;

  @override
  Widget build(BuildContext context) {
    final theme = ultravioletTheme;
    final child = MaterialApp.router(
      routerConfig: goRouter,
      theme: theme.copyWith(
        textTheme: GoogleFonts.nunitoSansTextTheme(theme.textTheme),
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
