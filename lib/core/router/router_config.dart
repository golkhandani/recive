import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';

import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/auth_screen/reset_password_code_page.dart';
import 'package:art_for_all/modules/auth_screen/reset_password_page.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_screen.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/core/router/scaffold_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/modules/auth_screen/register_page.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_page.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:art_for_all/modules/dashboard_explore_screen/map_art_page.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_screen.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_page.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/saved_items_page.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
import 'package:art_for_all/modules/onboarding_screen.dart/onboarding_screen.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

final authRoutes = [
  GoRoute(
    name: SplashScreen.name,
    path: '/${SplashScreen.name}',
    pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
  ),
  GoRoute(
    name: LoginScreen.name,
    path: '/${LoginScreen.name}',
    pageBuilder: (context, state) => const NoTransitionPage(child: LoginScreen()),
  ),
  GoRoute(
    name: RegisterScreen.name,
    path: '/${RegisterScreen.name}',
    pageBuilder: (context, state) => const NoTransitionPage(child: RegisterScreen()),
  ),
  GoRoute(
    name: ResetPasswordCodePage.name,
    path: '/${ResetPasswordCodePage.name}',
    pageBuilder: (context, state) => const NoTransitionPage(
      child: ResetPasswordCodePage(),
    ),
  ),
  GoRoute(
    name: ResetPasswordPage.name,
    path: '/${ResetPasswordPage.name}',
    pageBuilder: (context, state) => const NoTransitionPage(
      child: ResetPasswordPage(),
    ),
  )
];

final initRoutes = [
  GoRoute(
    name: OnboardingScreen.name,
    path: '/${OnboardingScreen.name}',
    pageBuilder: (context, state) {
      final page = state.uri.queryParameters['page'] ?? '0';
      return NoTransitionPage(child: OnboardingScreen(initialPage: int.tryParse(page) ?? 0));
    },
  ),
];

/////////////// DASHBOARD ///////////////////////

final dashboardRoutes = [
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: rootNavigatorKey,
    restorationScopeId: 'dashboard_page',
    redirect: (context, state) {
      if (state.name == '/${DashboardScreen.name}') {
        state.namedLocation(HomeScreen.name);
      }
      return;
    },
    pageBuilder: (context, state, child) {
      return CustomTransitionPage(
        key: state.pageKey,
        barrierColor: Colors.transparent,
        opaque: false,
        child: DashboardScreen(child: child),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Change the opacity of the screen using a Curve based on the the animation's
          // value
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
    branches: [
      /// HOME PAGE
      StatefulShellBranch(
        navigatorKey: homeNavigatorKey,
        restorationScopeId: 'home_page',
        routes: <RouteBase>[
          GoRoute(
            path: '/${DashboardScreen.name}/${HomeScreen.name}',
            name: HomeScreen.name,
            pageBuilder: (context, state) => _dashboardPageBuilder(
              state,
              const HomeScreen(),
            ),
            routes: [
              // VIEW ALL SCREEN
              GoRoute(
                  path: SearchScreen.name,
                  pageBuilder: (context, state) {
                    return _dashboardPageBuilder(
                      state,
                      SearchScreen(
                        filtersData: (state.extra as SearchScreenFiltersData?) ??
                            const SearchScreenFiltersData(),
                        isViewAll: true,
                        query: state.uri.queryParameters["q"],
                      ),
                    );
                  }),
              GoRoute(
                name: CategoryDetailScreen.name,
                path: '${CategoryDetailScreen.name}/:${CategoryDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  CategoryDetailScreen(
                    id: state.pathParameters[CategoryDetailScreen.pathParamId] ?? '',
                    extra: state.extra != null
                        ? CategoryAbstractModel.fromJson(
                            state.extra as Map<String, dynamic>,
                          )
                        : null,
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
                routes: [
                  GoRoute(
                    name: ArtDetailScreen.name + ArtistDetailScreen.name,
                    path: '${ArtistDetailScreen.name}/:${ArtistDetailScreen.pathParamId}',
                    pageBuilder: (context, state) => _dashboardPageBuilder(
                      state,
                      ArtistDetailScreen(
                        id: state.pathParameters[ArtistDetailScreen.pathParamId] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                name: NewsDetailScreen.name,
                path: '${NewsDetailScreen.name}/:${NewsDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  NewsDetailScreen(
                    id: state.pathParameters[NewsDetailScreen.pathParamId] ?? '',
                  ),
                ),
                routes: [
                  GoRoute(
                    name: NewsDetailScreen.name + ArtDetailScreen.name,
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
                name: ArtistDetailScreen.name,
                path: '${ArtistDetailScreen.name}/:${ArtistDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  ArtistDetailScreen(
                    id: state.pathParameters[ArtistDetailScreen.pathParamId] ?? '',
                  ),
                ),
              ),
              GoRoute(
                name: CommunityDetailScreen.name,
                path: '${CommunityDetailScreen.name}/:${CommunityDetailScreen.pathParamId}',
                pageBuilder: (context, state) => _dashboardPageBuilder(
                  state,
                  CommunityDetailScreen(
                    id: state.pathParameters[CommunityDetailScreen.pathParamId] ?? '',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      /// SEARCH SCREEN
      StatefulShellBranch(
        navigatorKey: searchNavigatorKey,
        restorationScopeId: 'search_page',
        routes: <RouteBase>[
          GoRoute(
              path: '/${DashboardScreen.name}/${SearchScreen.name}',
              pageBuilder: (context, state) {
                return _dashboardPageBuilder(
                  state,
                  SearchScreen(
                    query: state.uri.queryParameters["q"],
                  ),
                );
              }),
        ],
      ),

      StatefulShellBranch(
        navigatorKey: nearMeNavigatorKey,
        restorationScopeId: 'explore_page',
        routes: <RouteBase>[
          GoRoute(
              path: '/${DashboardScreen.name}/${NearMeScreen.name}',
              pageBuilder: (context, state) {
                return _dashboardPageBuilder(
                  state,
                  NearMeScreen(
                    query: state.uri.queryParameters["q"],
                  ),
                );
              }),
        ],
      ),

      StatefulShellBranch(
        navigatorKey: profileNavigatorKey,
        restorationScopeId: 'settings_page',
        routes: <RouteBase>[
          GoRoute(
              name: ProfileScreen.name,
              path: '/${DashboardScreen.name}/${ProfileScreen.name}',
              pageBuilder: (context, state) => _dashboardPageBuilder(
                    state,
                    const ProfileScreen(),
                  ),
              routes: [
                GoRoute(
                  name: SavedItemsPage.name,
                  path: SavedItemsPage.name,
                  pageBuilder: (context, state) => _dashboardPageBuilder(
                    state,
                    const SavedItemsPage(),
                  ),
                ),
              ]),
        ],
      ),
    ],
  ),
];

Page<void> _dashboardPageBuilder(GoRouterState state, Widget screen) {
  return MaterialPage<void>(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    child: screen,
    // transitionsBuilder: (
    //   context,
    //   animation,
    //   secondaryAnimation,
    //   child,
    // ) {
    //   return SlideTransition(
    //     position: animation.drive(
    //       Tween<Offset>(
    //         begin: const Offset(1, 0),
    //         end: Offset.zero,
    //       ).chain(
    //         CurveTween(curve: Curves.easeInOutCubic),
    //       ),
    //     ),
    //     child: child,
    //   );
    // },
  );
}
