import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/router/basic.dart';
import 'package:art_for_all/core/router/dashboard_screen.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/router/scaffold_screen.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/modules/detail_art_screen/detail_art_page.dart';
import 'package:art_for_all/modules/featured_art_screen/featured_art_page.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_page.dart';
import 'package:art_for_all/modules/profile_screen/profile_page.dart';
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

final extraRoutes = [
  GoRoute(
    name: 'privacy',
    path: '/privacy',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'about',
    path: '/about',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'contact',
    path: '/contact',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

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

final dashboardExtraRoutes = [
  GoRoute(
    name: 'notification',
    path: '/notification',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'settings',
    path: '/settings',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
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
Page<void> dashboardPageBuilder(GoRouterState state, Widget screen) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    child: screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        // FadeTransition(opacity: animation, child: child) ??
        SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeInOutCubic),
        ),
      ),
      child: child,
    ),
  );
}

GoRoute nearbyArtDetailRoute(String parentName) => GoRoute(
      name: parentName + ArtDetailScreen.name,
      path: '${ArtDetailScreen.name}/:${ArtDetailScreen.pathParamId}',
      pageBuilder: (context, state) {
        final pathParamId = state.pathParameters[ArtDetailScreen.pathParamId]!;

        final extraJson = state.extra as Map<String, dynamic>;
        final extra = ExtraData.fromJson(
          extraJson,
          (inner) => ArtDetailSummaryData.fromJson(inner as Map<String, dynamic>),
        );
        return dashboardPageBuilder(
          state,
          ArtDetailScreen(id: pathParamId, extra: extra),
        );
      },
    );

GoRoute categoryDetailRoute(String parentName) => GoRoute(
      name: parentName + CategoryDetailScreen.name,
      path: '${CategoryDetailScreen.name}/:${CategoryDetailScreen.pathParamId}',
      pageBuilder: (context, state) {
        final pathParamId = state.pathParameters[CategoryDetailScreen.pathParamId]!;

        final extraJson = state.extra as Map<String, dynamic>;
        final extra = ExtraData.fromJson(
          extraJson,
          (inner) => CategorySummaryData.fromJson(
            inner as Map<String, dynamic>,
          ),
        );
        return dashboardPageBuilder(
          state,
          CategoryDetailScreen(id: pathParamId, extra: extra),
        );
      },
    );

GoRoute packageDetailRoute(String parentName) => GoRoute(
      name: parentName + PackageDetailScreen.name,
      path: '${PackageDetailScreen.name}/:${PackageDetailScreen.pathParamId}',
      pageBuilder: (context, state) {
        final pathParamId = state.pathParameters[PackageDetailScreen.pathParamId]!;

        final extraJson = state.extra as Map<String, dynamic>;
        final extra = ExtraData.fromJson(
          extraJson,
          (inner) => PackageSummaryData.fromJson(
            inner as Map<String, dynamic>,
          ),
        );

        return dashboardPageBuilder(
          state,
          PackageDetailScreen(id: pathParamId, extra: extra),
        );
      },
      routes: [
        nearbyArtDetailRoute(PackageDetailScreen.name),
      ],
    );

GoRoute newsDetailRoute(String parentName) => GoRoute(
      name: parentName + NewsDetailScreen.name,
      path: '${NewsDetailScreen.name}/:${NewsDetailScreen.pathParamId}',
      pageBuilder: (context, state) {
        final pathParamId = state.pathParameters[NewsDetailScreen.pathParamId]!;

        final extraJson = state.extra as Map<String, dynamic>;
        final extra = ExtraData.fromJson(
          extraJson,
          (inner) => NewsSummaryData.fromJson(
            inner as Map<String, dynamic>,
          ),
        );
        return dashboardPageBuilder(
          state,
          NewsDetailScreen(id: pathParamId, extra: extra),
        );
      },
    );

final dashboardRoutes = [
  ...dashboardExtraRoutes,
  GoRoute(
    name: DashboardScreen.name,
    path: '/${DashboardScreen.name}',
    redirect: (context, state) async {
      final isLoggedIn = locator.get<IUserService>().isLoggedIn;
      if (isLoggedIn) {
        return state.namedLocation(
          DashboardWrapper.dashboardRouteNameToSelectedIndexMap.keys.first,
        );
      } else {
        return state.namedLocation(LoginScreen.name);
      }
    },
    builder: (context, state) => const DashboardScreen(),
  ),
  StatefulShellRoute.indexedStack(
    //navigatorKey: dashboardNavigatorKey,
    pageBuilder: (context, state, child) {
      return MaterialPage(
        child: HeroControllerScope(
            controller: MaterialApp.createMaterialHeroController(),
            child: LayoutBuilder(
              // yes that LayoutBuilder is important. I don't know why
              builder: (ctx, constraints) => DashboardWrapper(child: child),
            )),
      );
    },
    builder: (BuildContext context, GoRouterState state, StatefulNavigationShell child) {
      return DashboardWrapper(child: child);
    },
    branches: [
      /// HOME PAGE
      StatefulShellBranch(
        navigatorKey: homeNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
              name: HomeScreen.name,
              path: '/${DashboardScreen.name}/${HomeScreen.name}',
              pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const HomeScreen(),
                  ),
              routes: [
                newsDetailRoute(HomeScreen.name),
                packageDetailRoute(PackagesScreen.name),
                nearbyArtDetailRoute(HomeScreen.name),
                GoRoute(
                  name: CategoriesScreen.name,
                  path: CategoriesScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const CategoriesScreen(),
                  ),
                  routes: [
                    categoryDetailRoute(CategoriesScreen.name),
                  ],
                ),
                GoRoute(
                  name: NewsScreen.name,
                  path: NewsScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const NewsScreen(),
                  ),
                  routes: [
                    newsDetailRoute(NewsScreen.name),
                  ],
                ),
                GoRoute(
                  name: FeaturedScreen.name,
                  path: FeaturedScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const FeaturedScreen(),
                  ),
                  routes: [
                    nearbyArtDetailRoute(FeaturedScreen.name),
                  ],
                ),
              ]),
        ],
      ),

      /// NEAR BY SCREEN
      StatefulShellBranch(
        navigatorKey: nearMeNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
              name: NearMeScreen.name,
              path: '/${DashboardScreen.name}/${NearMeScreen.name}',
              pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const NearMeScreen(),
                  ),
              routes: [
                nearbyArtDetailRoute(NearMeScreen.name),
              ]),
        ],
      ),

      /// SEARCH SCREEN
      // StatefulShellBranch(
      //   navigatorKey: searchNavigatorKey,
      //   routes: <RouteBase>[
      //     GoRoute(
      //       name: SearchScreen.name,
      //       path: '/${DashboardScreen.name}/${SearchScreen.name}',
      //       pageBuilder: (context, state) {
      //         // GoRouterState.of(context).;
      //         // keywordQueryKey
      //         return dashboardPageBuilder(
      //           state,
      //           SearchScreen(
      //             keyword: state.uri.queryParameters[SearchScreen.keywordQueryKey],
      //           ),
      //         );
      //       },
      //       routes: [
      //         nearbyArtDetailRoute(SearchScreen.name),
      //       ],
      //     ),
      //   ],
      // ),
      StatefulShellBranch(
        navigatorKey: profileNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: ProfileScreen.name,
            path: '/${DashboardScreen.name}/${ProfileScreen.name}',
            pageBuilder: (context, state) => dashboardPageBuilder(
              state,
              const ProfileScreen(),
            ),
            routes: [
              GoRoute(
                name: BookmarksScreen.name,
                path: BookmarksScreen.name,
                pageBuilder: (context, state) => dashboardPageBuilder(
                  state,
                  const BookmarksScreen(),
                ),
                routes: [
                  nearbyArtDetailRoute(BookmarksScreen.name),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
