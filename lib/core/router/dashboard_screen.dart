import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/modules/featured_art_screen/featured_art_page.dart';
import 'package:art_for_all/modules/map_art_screen/map_art_page.dart';
import 'package:art_for_all/modules/profile_screen/profile_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

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
  final StatefulNavigationShell child;

  static Map<String, int> dashboardRouteNameToSelectedIndexMap = {
    HomeScreen.name: 0,
    NearMeScreen.name: 1,
    // SearchScreen.name: 2,
    ProfileScreen.name: 2,
  };
  final navigationService = locator.get<NavigationService>();

  int calculateDashboardSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    final name = dashboardRouteNameToSelectedIndexMap.keys
        .firstWhereOrNull((element) => location.contains(element));

    return dashboardRouteNameToSelectedIndexMap[name] ?? 0;
  }

  void onItemTapped(int index) {
    child.goBranch(index, initialLocation: index == child.currentIndex);
  }

  final items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.near_me_outlined),
      label: 'Arts',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.route_outlined),
    //   label: 'Routes',
    // ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: calculateDashboardSelectedIndex(context),
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
