import 'package:art_for_all/core/router/basic.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/core/router/scaffold_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_page.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/map_art_page.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_page.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class TestRoute extends StatelessWidget {
  const TestRoute({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return ScaffoldShell(child: Center(child: Text(text)));
  }
}

final authRoutes = [
  GoRoute(
    name: SplashScreen.name,
    path: '/${SplashScreen.name}',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    name: LoginScreen.name,
    path: '/${LoginScreen.name}',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: RegisterScreen.name,
    path: '/${RegisterScreen.name}',
    builder: (context, state) => const RegisterScreen(),
  ),
];

final initRoutes = [
  GoRoute(
    name: OnboardingScreen.name,
    path: '/${OnboardingScreen.name}',
    builder: (context, state) {
      final page = state.uri.queryParameters['page'] ?? '0';
      return OnboardingScreen(initialPage: int.tryParse(page) ?? 0);
    },
  ),
];

/////////////// DASHBOARD ///////////////////////

final dashboardRoutes = [
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: rootNavigatorKey,
    redirect: (context, state) {
      if (state.name == '/${DashboardScreen.name}') {
        state.namedLocation(HomeScreen.name);
      }
      return;
    },
    builder: (context, state, child) {
      return DashboardScreen(child: child);
    },
    branches: [
      /// HOME PAGE
      StatefulShellBranch(
        navigatorKey: homeNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            path: '/${DashboardScreen.name}/${HomeScreen.name}',
            name: HomeScreen.name,
            pageBuilder: (context, state) => _dashboardPageBuilder(
              state,
              const HomeScreen(),
            ),
            routes: [
              GoRoute(
                name: CategoryDetailScreen.name,
                path: '${CategoryDetailScreen.name}/:${CategoryDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  CategoryDetailScreen(
                    id: state.pathParameters[CategoryDetailScreen.pathParamId] ?? '',
                  ),
                ),
              ),
              GoRoute(
                name: EventDetailScreen.name,
                path: '${EventDetailScreen.name}/:${EventDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  EventDetailScreen(
                    id: state.pathParameters[EventDetailScreen.pathParamId] ?? '',
                  ),
                ),
                routes: [
                  GoRoute(
                    name: EventDetailScreen.name + ArtDetailScreen.name,
                    path: '${ArtDetailScreen.name}/:${ArtDetailScreen.pathParamId}',
                    pageBuilder: (context, state) => _dashboardPageBuilder(
                      state,
                      ArtDetailScreen(
                        id: state.pathParameters[ArtDetailScreen.pathParamId] ?? '',
                      ),
                    ),
                  )
                ],
              ),
              GoRoute(
                name: ArtDetailScreen.name,
                path: '${ArtDetailScreen.name}/:${ArtDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  ArtDetailScreen(
                    id: state.pathParameters[ArtDetailScreen.pathParamId] ?? '',
                  ),
                ),
              )
            ],
          ),
        ],
      ),

      /// NEAR BY SCREEN
      StatefulShellBranch(
        navigatorKey: nearMeNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: NearMeScreen.name,
            path: '/${DashboardScreen.name}/${NearMeScreen.name}',
            pageBuilder: (context, state) => _dashboardPageBuilder(
              state,
              const NearMeScreen(),
            ),
            routes: const [],
          ),
        ],
      ),

      StatefulShellBranch(
        navigatorKey: profileNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: ProfileScreen.name,
            path: '/${DashboardScreen.name}/${ProfileScreen.name}',
            pageBuilder: (context, state) => _dashboardPageBuilder(
              state,
              const ProfileScreen(),
            ),
            routes: const [],
          ),
        ],
      ),
    ],
  ),
];

Page<void> _dashboardPageBuilder(GoRouterState state, Widget screen) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    child: screen,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOutCubic),
          ),
        ),
        child: child,
      );
    },
  );
}
