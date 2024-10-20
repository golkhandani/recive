import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:recive/core/components/scaffold_shell.dart';
import 'package:recive/modules/bookmarks/bookmarks_screen.dart';
import 'package:recive/modules/categories_page/categories_screen.dart';
import 'package:recive/modules/categories_page/category_detail_screen.dart';
import 'package:recive/modules/dashboard/dashboard_screen.dart';
import 'package:recive/modules/featured_page/featured_screen.dart';
import 'package:recive/modules/home_page/home_screen.dart';
import 'package:recive/modules/introduction_page/introduction_screen.dart';
import 'package:recive/modules/introduction_page/splash_screen.dart';
import 'package:recive/modules/login_page/login_screen.dart';
import 'package:recive/modules/near_me_page/near_me_detail_screen.dart';
import 'package:recive/modules/near_me_page/near_me_screen.dart';
import 'package:recive/modules/news_page/news_detail_screen.dart';
import 'package:recive/modules/news_page/news_screen.dart';
import 'package:recive/modules/package_page/package_detail_screen.dart';
import 'package:recive/modules/package_page/packages_screen.dart';
import 'package:recive/modules/profile/profile_screen.dart';
import 'package:recive/modules/search_page/search_screen.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/services/realm_service.dart';

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
      return OnboardingScreen(initalPage: int.tryParse(page) ?? 0);
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
      final RealmApplicationService applicationService = locator.get();
      final isLoggedIn = await applicationService.checkLogin();
      if (kDebugMode) {
        print("________ | DashboardScreen isLoggedIn $isLoggedIn");
      }
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
      StatefulShellBranch(
        navigatorKey: searchNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: SearchScreen.name,
            path: '/${DashboardScreen.name}/${SearchScreen.name}',
            pageBuilder: (context, state) {
              // GoRouterState.of(context).;
              // keyworkQueryKey
              return dashboardPageBuilder(
                state,
                SearchScreen(
                  keyword: state.uri.queryParameters[SearchScreen.keywordQueryKey],
                ),
              );
            },
            routes: [
              nearbyArtDetailRoute(SearchScreen.name),
            ],
          ),
        ],
      ),
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
