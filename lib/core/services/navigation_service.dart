import 'package:art_for_all/modules/dashboard_home_screen/featured_art_page.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_screen.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

extension BuildContextGoRouter on BuildContext {
  void neglect(String location, {Object? extra}) =>
      Router.neglect(this, () => go(location, extra: extra));

  void neglectNamed(String name) => Router.neglect(this, () => goNamed(name));
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> dashboardNavigatorKey = GlobalKey();

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> nearMeNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> searchNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> compassNavigatorKey = GlobalKey();

class NavigationService {
  final GlobalKey<NavigatorState> rootNavigatorKey;
  final GlobalKey<NavigatorState> homeNavigatorKey;
  final GlobalKey<NavigatorState> nearMeNavigatorKey;
  final GlobalKey<NavigatorState> searchNavigatorKey;
  final GlobalKey<NavigatorState> profileNavigatorKey;
  NavigationService({
    required this.rootNavigatorKey,
    required this.homeNavigatorKey,
    required this.nearMeNavigatorKey,
    required this.searchNavigatorKey,
    required this.profileNavigatorKey,
  });

  BuildContext get rootContext => rootNavigatorKey.currentState!.context;
  GoRouterState get state => GoRouterState.of(rootContext);
  GoRouter get router => GoRouter.of(rootContext);

  BuildContext get homeContext => homeNavigatorKey.currentState!.context;

  // Uri get currentUri => router.routeInformationProvider.value.uri;

  String get homeUrl => '/${DashboardScreen.name}/${HomeScreen.name}';
  String get searchUrl => '/${DashboardScreen.name}/${SearchScreen.name}';

  void moveTo(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return GoRouter.of(rootContext).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<T?> pushTo<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return GoRouter.of(rootContext).pushNamed<T?>(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<void> logoutTo(String name) async {
    while (canBack) {
      backTo(rootContext);
    }
    await GoRouter.of(rootContext).pushReplacementNamed(name);
  }

  void backTo(context) {
    return GoRouter.of(rootContext).canPop() ? GoRouter.of(rootContext).pop() : null;
    // GoRouter.of(rootContext).replaceNamed(DashboardScreen.name);
  }

  bool get canBack => GoRouter.of(rootContext).canPop();

  Uri getUri(context) => GoRouterState.of(context).uri;
}
