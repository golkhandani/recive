import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    HomeScreen.name: 0,
    NearMeScreen.name: 1,
    SearchScreen.name: 2,
    ProfileScreen.name: 3,
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
      final String location = GoRouterState.of(context).uri.path;
      final name = dashboardRouteNameToSelectedIndexMap.keys
          .firstWhereOrNull((element) => location.contains(element));

      return dashboardRouteNameToSelectedIndexMap[name] ?? 0;
    }

    final currentIndex = calculateDashboardSelectedIndex();
    final items = [
      NavigationItem(
        iconData: FontAwesomeIcons.calendar,
        label: 'Events',
      ),
      NavigationItem(
        iconData: FontAwesomeIcons.compass,
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
      activeColor: context.theme.textTheme.bodyLarge!.color!,
      inactiveColor: context.theme.disabledColor,
      backgroundColor: context.theme.primaryColor,
      useFloatingNavBar: true,
      handleTopSafePadding: false,
      child: child,
    );
  }
}
