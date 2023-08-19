import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recive/features/dashboard/dashboard_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> nearMeNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> searchNavigatorKey = GlobalKey();
final GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey();

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

  navigateTo(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    GoRouter.of(rootContext).goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  backTo(context) {
    print(
        "GoRouter.of(rootContext).canPop() ${GoRouter.of(rootContext).canPop()}");
    GoRouter.of(rootContext).canPop()
        ? GoRouter.of(rootContext).pop()
        : navigateTo(DashboardScreen.name);
  }

  bool get canBack => GoRouter.of(rootContext).canPop();
}
