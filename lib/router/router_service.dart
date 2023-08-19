import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/features/notification/notification_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/profile_page/profile_screen.dart';
import 'package:recive/features/search_page/search_screen.dart';
import 'package:recive/layout/scaffold_shell.dart';
import 'package:recive/router/navigation_service.dart';

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
    name: 'login',
    path: '/login',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
  GoRoute(
    name: 'signup',
    path: '/signup',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final dashboardExtraRoutes = [
  GoRoute(
    name: NotificationScreen.name,
    path: '/${NotificationScreen.name}',
    builder: (context, state) => const NotificationScreen(),
  ),
  GoRoute(
    name: 'settings',
    path: '/settings',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

final initRoutes = [
  GoRoute(
    name: 'intro',
    path: '/intro',
    builder: (context, state) => TestRoute(text: state.fullPath ?? ''),
  ),
];

GoRoute detailRoute(String parentName) => GoRoute(
      name: parentName + DetailScreen.name,
      path:
          '${DetailScreen.name}/:${DetailScreen.pathParamType}/:${DetailScreen.pathParamId}',
      pageBuilder: (context, state) {
        final pathParamId = state.pathParameters[DetailScreen.pathParamId]!;
        final pathParamPostType =
            state.pathParameters[DetailScreen.pathParamType] ??
                DetailType.unknown.name;
        return dashboardPageBuilder(
          state,
          DetailScreen(
            id: pathParamId,
            type: DetailType.fromString(pathParamPostType),
          ),
        );
      },
    );

final dashboardRoutes = [
  ...dashboardExtraRoutes,
  GoRoute(
    name: DashboardScreen.name,
    path: '/${DashboardScreen.name}',
    redirect: (context, state) => state.namedLocation(
      DashboardWrapper.dashboardRouteNameToSelectedIndexMap.keys.first,
    ),
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
    builder: (BuildContext context, GoRouterState state,
        StatefulNavigationShell child) {
      return DashboardWrapper(child: child);
    },
    branches: [
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
                detailRoute(''),
                detailRoute(HomeScreen.name),
                GoRoute(
                  name: CategoriesScreen.name,
                  path: CategoriesScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const CategoriesScreen(),
                  ),
                ),
                GoRoute(
                  name: NewsScreen.name,
                  path: NewsScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const NewsScreen(),
                  ),
                ),
                GoRoute(
                  name: FeaturedScreen.name,
                  path: FeaturedScreen.name,
                  pageBuilder: (context, state) => dashboardPageBuilder(
                    state,
                    const FeaturedScreen(),
                  ),
                ),
              ]),
        ],
      ),
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
                detailRoute(NearMeScreen.name),
              ]),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: searchNavigatorKey,
        routes: <RouteBase>[
          GoRoute(
            name: SearchScreen.name,
            path: '/${DashboardScreen.name}/${SearchScreen.name}',
            pageBuilder: (context, state) => dashboardPageBuilder(
              state,
              const SearchScreen(),
            ),
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
          ),
        ],
      )
    ],
  ),
];

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
