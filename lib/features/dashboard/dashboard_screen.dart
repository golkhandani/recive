import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recive/components/navigation_item.dart';
import 'package:recive/features/near_me_page/near_me_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/profile_page/profile_screen.dart';
import 'package:recive/features/search_page/search_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/navigation_shell.dart';
import 'package:recive/router/navigation_service.dart';

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
    SearchScreen.name: 2,
    ProfileScreen.name: 3,
  };
  final navigationService = locator.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      // final name = dashboardRouteNameToSelectedIndexMap.keys.firstWhereOrNull(
      //     (element) => dashboardRouteNameToSelectedIndexMap[element] == index);
      // navigationService
      //     .navigateTo(name ?? dashboardRouteNameToSelectedIndexMap.keys.first);

      child.goBranch(
        index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
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
        iconData: Icons.calendar_month,
        label: 'Events',
      ),
      NavigationItem(
        iconData: Icons.near_me_rounded,
        label: 'Near Me',
      ),
      NavigationItem(
        iconData: Icons.business,
        label: 'Search',
      ),
      NavigationItem(
        iconData: Icons.notification_important_rounded,
        label: 'Profile',
      ),
    ];

    return NavigationShell(
      items: items,
      currentIndex: currentIndex,
      onTap: onItemTapped,
      activeColor: context.colorScheme.tertiary,
      inactiveColor: context.colorScheme.onTertiaryContainer,
      backgroundColor: context.colorScheme.tertiaryContainer,
      useFloatingNavBar: true,
      handleTopSafePadding: false,
      child: child,
    );
  }
}
