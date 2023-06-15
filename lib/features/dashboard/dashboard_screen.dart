import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recive/components/navigation_item.dart';
import 'package:recive/features/featured/featured_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/navigation_shell.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/router/router_service.dart';

class DashboardScreen extends StatelessWidget {
  static String name = 'dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DashboardWrapper extends StatelessWidget {
  DashboardWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  static Map<String, int> dashboardRouteNameToSelectedIndexMap = {
    FeaturedScreen.name: 0,
    ProfileScreen.name: 1,
    RecipesScreen.name: 2,
  };
  final navigationService = locator.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      final name = dashboardRouteNameToSelectedIndexMap.keys.firstWhereOrNull(
          (element) => dashboardRouteNameToSelectedIndexMap[element] == index);
      navigationService
          .navigateTo(name ?? dashboardRouteNameToSelectedIndexMap.keys.first);
    }

    int calculateDashboardSelectedIndex() {
      final String location = GoRouterState.of(context).location;
      final name = dashboardRouteNameToSelectedIndexMap.keys
          .firstWhereOrNull((element) => location.contains(element));

      return dashboardRouteNameToSelectedIndexMap[name] ?? 0;
    }

    final currentIndex = calculateDashboardSelectedIndex();
    final items = [
      NavigationItem(
        iconData: Icons.home,
        label: 'Inputs',
      ),
      NavigationItem(
        iconData: Icons.business,
        label: 'Cards',
      ),
      NavigationItem(
        iconData: Icons.notification_important_rounded,
        label: 'Actions',
      ),
    ];

    return NavigationShell(
      items: items,
      currentIndex: currentIndex,
      onTap: onItemTapped,
      activeColor: Colors.amber,
      inactiveColor: Colors.white,
      backgroundColor: Colors.black,
      useFloatingNavBar: false,
      child: child,
    );
  }
}
