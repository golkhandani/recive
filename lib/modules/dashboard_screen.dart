import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/services/location_service.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/context_extensions.dart';
import 'package:art_for_all/core/widgets/lottie_safe_loading.dart';
import 'package:art_for_all/modules/dashboard_setting_screen/profile_bloc.dart';
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

  @override
  void initState() {
    profileBloc.getUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAll();
      geolocator.getUserPosition();
    });
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
      label: 'Search'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.explore_outlined),
      label: 'Compass'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings_outlined),
      label: 'Setting'.toUpperCase(),
    ),
  ];

  bool loadAllIsDone = false;

  _loadAll() async {
    // TODO: Temporary fix until go router add load all branch feature
    // it's coming soon
    for (var i = 0; i < items.length; i++) {
      onItemTapped(i);
      await Future.delayed(kPageLoaderDuration);
    }
    onItemTapped(0);

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
        ],
        child: Stack(
          children: [
            Positioned.fill(
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
            ),
            Positioned.fill(
              child: AnimatedSwitcher(
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                duration: kLoadingDuration,
                child: loadAllIsDone
                    ? null
                    : Container(
                        color: context.colorTheme.background,
                        child: const LottieSafeLoading(),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
