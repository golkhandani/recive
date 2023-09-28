import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';

import 'package:recive/core/components/navigation_item.dart';
import 'package:recive/core/components/navigation_shell.dart';
import 'package:recive/modules/home_page/home_screen.dart';
import 'package:recive/modules/near_me_page/near_me_screen.dart';
import 'package:recive/modules/profile_page/profile_screen.dart';
import 'package:recive/modules/search_page/search_screen.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';

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
    // PackagesScreen.name: 2,
    SearchScreen.name: 2,
    ProfileScreen.name: 3,
  };
  final navigationService = locator.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      child.goBranch(
        index,
        initialLocation: index == child.currentIndex,
      );
    }

    int calculateDashboardSelectedIndex() {
      final String location = GoRouterState.of(context).uri.path;
      final name = dashboardRouteNameToSelectedIndexMap.keys
          .firstWhereOrNull((element) => location.contains(element));

      return dashboardRouteNameToSelectedIndexMap[name] ?? 0;
    }

    final currentIndex = calculateDashboardSelectedIndex();
    final items = [
      NavigationItem(
        iconData: Icons.home_outlined,
        label: 'Home',
      ),
      NavigationItem(
        iconData: Icons.near_me_outlined,
        label: 'Arts',
      ),
      // NavigationItem(
      //   iconData: Icons.group_work_outlined,
      //   label: 'Packages',
      // ),
      NavigationItem(
        iconData: Icons.route_outlined,
        label: 'Routes',
      ),
      NavigationItem(
        iconData: Icons.person_outline,
        label: 'Profile',
      ),
    ];

    return NavigationShell(
      items: items,
      currentIndex: currentIndex,
      onTap: onItemTapped,
      activeColor: context.colorScheme.primaryContainer,
      inactiveColor: context.colorScheme.onTertiaryContainer,
      backgroundColor: context.colorScheme.tertiaryContainer,
      useFloatingNavBar: true,
      handleTopSafePadding: false,
      child: child,
    );
  }
}
