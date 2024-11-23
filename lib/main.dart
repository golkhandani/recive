import 'dart:async';
import 'dart:ui';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/router/router_config.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/services/notification_banner_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/theme/theme_cubit.dart';
import 'package:art_for_all/environment.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_page.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:art_for_all/utils/afa_scroll_behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  // LicenseRegistry.addLicense(() async* {
  //   try {
  //     final license = await rootBundle.loadString('google_fonts/OFL.txt');
  //     yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  //   } catch (e) {}
  // });
  runZonedGuarded(() async {
    await SentryFlutter.init((options) {
      options.dsn =
          'https://${Environment.sentryHost}.ingest.us.sentry.io/${Environment.sentryKey}';
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
      GoRouter.optionURLReflectsImperativeAPIs = true;
      usePathUrlStrategy();

      final goRouter = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: initRoute,
        navigatorKey: rootNavigatorKey,
        routes: [
          ...initRoutes,
          ...authRoutes,
          ...dashboardRoutes,
        ],
        onException: (context, state, _) => state.namedLocation(HomeScreen.name),
      );

      return runApp(Application(goRouter: goRouter));
    });
  }, (error, stack) {
    if (kDebugMode) {
      print("_______________ERROR_______________");
      print(stack.toString());
      print(error);
    }
    Logger.error("Application Error", error, stack);
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

  Future<void> loadAsset() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext _) {
    final child = MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeBloc),
      ],
      child: BlocBuilder<ThemeCubit, ThemeCubitState>(
          bloc: themeBloc,
          builder: (_, appTheme) {
            final statusBarItemBrightness =
                appTheme.colorPalette.brightness == Brightness.light
                    ? Brightness.dark
                    : Brightness.light;

            final overlayStyle = SystemUiOverlayStyle(
              statusBarColor: appTheme.colorPalette.navBackground,
              statusBarIconBrightness: statusBarItemBrightness,
              systemNavigationBarColor: appTheme.colorPalette.navBackground,
              statusBarBrightness: appTheme.colorPalette.brightness,
              systemNavigationBarDividerColor: appTheme.colorPalette.navBackground,
              systemNavigationBarIconBrightness: statusBarItemBrightness,
            );
            SystemChrome.setSystemUIOverlayStyle(overlayStyle);
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: ScrollConfiguration(
                behavior: AFAScrollBehavior(),
                child: MrzgThemeProvider(
                  palette: appTheme.colorPalette,
                  typography: MrzgThemeTypography(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: GoogleFonts.raleway().fontFamily,
                    ),
                    palette: appTheme.colorPalette,
                  ),
                  child: Builder(builder: (context) {
                    return MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        theme: context.themeData,
                        scrollBehavior: const MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                            PointerDeviceKind.stylus,
                            PointerDeviceKind.unknown,
                            PointerDeviceKind.trackpad
                          },
                        ),
                        routerConfig: widget.goRouter,
                        builder: (context, child) {
                          Widget ch = Container(
                            constraints: const BoxConstraints(maxHeight: 900, maxWidth: 600),
                            child: child!,
                          );
                          if (kIsWeb) {
                            ch = MobileFrame(child: ch);
                          }
                          return FutureBuilder(
                              future: loadAsset(),
                              builder: (context, snapshot) {
                                return Overlay(
                                  initialEntries: [
                                    OverlayEntry(
                                      builder: (context) => ch,
                                    )
                                  ],
                                );
                              });
                        });
                  }),
                ),
              ),
            );
          }),
    );
    return child;
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;

  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actual = MediaQuery.of(context).size;
        if (actual.height * 0.7 > actual.width) {
          mobileFrameHeight = null;
          mobileFrameWidth = null;
          return child;
        }
        // Mobile-like width
        mobileFrameHeight = (constraints.maxHeight - 80) / 0.7;
        mobileFrameWidth = (9 / 23) * mobileFrameHeight!;
        return Scaffold(
          backgroundColor: Colors.grey[200], // Background for non-mobile area
          body: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: kMediumBorderRadius,
                          child: Image.asset(
                            'assets/app_icon.png',
                            width: context.vWidth / 2,
                            height: context.vWidth / 2,
                          ),
                        ),
                        Text(
                          'Vancouver Art Compass',
                          style: context.typographyTheme.bodyMedium.onBackground.textStyle,
                        )
                      ],
                    ),
                    const StoreButtons(),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    width: constraints.maxWidth < mobileFrameWidth!
                        ? constraints.maxWidth
                        : mobileFrameWidth!,
                    height: mobileFrameHeight,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: kSmallBorderRadius,
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StoreButtons extends StatelessWidget {
  const StoreButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            // Link to Apple App Store
            // print("Apple App Store button tapped");
          },
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download on the',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      'App Store',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            // Link to Google Play Store
            // print("Google Play Store button tapped");
          },
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get it on',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    Text(
                      'Google Play',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
