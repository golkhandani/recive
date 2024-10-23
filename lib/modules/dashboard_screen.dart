import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  static String name = 'dashboard';
  const DashboardScreen({
    super.key,
    required this.child,
  });
  final StatefulNavigationShell child;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final navigationService = locator.get<NavigationService>();
  final profileBloc = locator.get<ProfileBloc>();

  @override
  void initState() {
    profileBloc.getUser();
    super.initState();
  }

  void onItemTapped(int index) {
    widget.child.goBranch(
      index,
      initialLocation: index == widget.child.currentIndex,
    );
  }

  final items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home_outlined),
      label: 'Home'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.search),
      label: 'Explore'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings),
      label: 'Setting'.toUpperCase(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileBloc),
      ],
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: kExtraTinyBorder.copyWith(
                color: context.colorTheme.onPrimaryContainer,
              ),
            ),
          ),
          child: BottomNavigationBar(
            items: items,
            currentIndex: widget.child.currentIndex,
            onTap: onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
