import 'dart:async';
import 'dart:ui';

import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/router/router_config.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/services/notification_banner_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:art_for_all/utils/afa_scroll_behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  runZonedGuarded(() async {
    await SentryFlutter.init((options) {
      options.dsn =
          'https://66589a0fc77fcde8e26d6f0362c04fad@o4508033221787648.ingest.us.sentry.io/4508033222639616';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    }, appRunner: () async {
      PlatformDispatcher.instance.onError = (error, stack) {
        if (kDebugMode) {
          print(stack.toString());
          print(error);
        }

        return true;
      };

      LicenseRegistry.addLicense(() async* {
        final license = await rootBundle.loadString('google_fonts/OFL.txt');
        yield LicenseEntryWithLineBreaks(['google_fonts'], license);
      });

      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await setupNavigation();
      await setupStorage();
      await setupServices();
      await setupRepositories();
      await setupBloc();

      final authService = locator.get<IUserService>();
      final bool isLoggedIn = authService.isLoggedIn;
      // if user is logged in restore the session
      if (isLoggedIn) {
        authService.restoreSession();
      }

      const initRoute = '/${SplashScreen.name}';
      final goRouter = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: initRoute,
        navigatorKey: rootNavigatorKey,
        routes: [
          ...initRoutes,
          ...authRoutes,
          ...dashboardRoutes,
        ],
      );

      FlutterNativeSplash.remove();
      return runApp(Application(goRouter: goRouter));
    });
  }, (error, stack) {
    if (kDebugMode) {
      print("_______________ERROR_______________");
      print(stack.toString());
      print(error);
    }
  });
}

class Application extends StatefulWidget {
  const Application({super.key, required this.goRouter});
  final GoRouter goRouter;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final themeBloc = locator.get<ThemeCubit>();
  final key = locator.get<NavigationService>();
  @override
  void initState() {
    locator.registerLazySingleton(() => NotificationBannerService(key.rootNavigatorKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeBloc),
      ],
      child: BlocBuilder<ThemeCubit, ThemeCubitState>(
          bloc: themeBloc,
          builder: (context, appTheme) {
            final statusBarItemBrightness =
                appTheme.colorPalette.brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light;

            final systemOverlayBrightness =
                appTheme.colorPalette.brightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light;
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: appTheme.colorPalette.secondaryContainer,
                statusBarIconBrightness: statusBarItemBrightness,
              ),
            );
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: systemOverlayBrightness,
              child: ScrollConfiguration(
                behavior: AFAScrollBehavior(),
                child: MrzgThemeProvider(
                  palette: appTheme.colorPalette,
                  typography: MrzgThemeTypography(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: GoogleFonts.josefinSans().fontFamily,
                    ),
                    palette: appTheme.colorPalette,
                  ),
                  child: Builder(builder: (context) {
                    return MaterialApp.router(
                      theme: context.themeData,
                      scrollBehavior: const MaterialScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                          PointerDeviceKind.stylus,
                          PointerDeviceKind.unknown
                        },
                      ),
                      routerConfig: widget.goRouter,
                      builder: (context, child) => Container(
                        constraints: const BoxConstraints(maxHeight: 900, maxWidth: 600),
                        child: child!,
                      ),
                    );
                  }),
                ),
              ),
            );
          }),
    );
    return child;
  }
}
