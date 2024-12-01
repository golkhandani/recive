import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/location_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/modules/art_detail_screen/user_interaction_bloc.dart';
import 'package:art_for_all/modules/category_detail_screen/category_list_bloc.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
import 'package:art_for_all/modules/splash_screen/splash_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  final geolocator = locator.get<ILocationService>();
  final profileBloc = locator.get<ProfileBloc>();
  final interactionBloc = locator.get<UserInteractionBloc>();
  final categoryBloc = locator.get<CategoryListBloc>();

  @override
  void initState() {
    profileBloc.getUser();
    interactionBloc.getSavedItems();
    categoryBloc.loadAllCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAll();
      geolocator.getUserPosition();
    });
    super.initState();
  }

  @override
  void dispose() {
    profileBloc.close();
    interactionBloc.close();
    categoryBloc.close();
    super.dispose();
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
      activeIcon: const Icon(Icons.home),
      label: 'Home'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.manage_search),
      activeIcon: const Icon(Icons.search),
      label: 'Search'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.explore_outlined),
      activeIcon: const Icon(Icons.explore),
      label: 'Compass'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person_outline),
      activeIcon: const Icon(Icons.person),
      label: 'Profile'.toUpperCase(),
    ),
  ];

  bool loadAllIsDone = false;

  _loadAll() async {
    // TODO: Temporary fix until go router add load all branch feature
    // it's coming soon
    final needFullLoad = (GoRouterState.of(context).fullPath?.split("/").length ?? 0) <= 3;
    if (needFullLoad) {
      for (var i = 0; i < items.length; i++) {
        onItemTapped(i);
        await Future.delayed(
          i == 2 ? const Duration(seconds: 1) : kPageLoaderDuration,
        );
      }
      onItemTapped(0);
    }

    setState(() {
      loadAllIsDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileBlocState>(
      bloc: profileBloc,
      listener: (context, state) {
        final image = state.user?.imageUrl;
        if (image?.isEmpty ?? true) return;

        precacheImage(CachedNetworkImageProvider(image!), context);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: profileBloc),
          BlocProvider.value(value: interactionBloc),
          BlocProvider.value(value: categoryBloc),
        ],
        child: Stack(
          children: [
            Positioned.fill(
              child: Scaffold(
                backgroundColor: context.colorTheme.background,
                body: Center(
                  child: widget.child,
                ),
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
            ),
            Positioned.fill(
              child: AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                duration: kLoadingDuration,
                child: loadAllIsDone ? null : const LottieSafeLoadingWithBackground(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
