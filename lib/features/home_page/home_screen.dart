import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/home_page/sections/category_section.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/features/home_page/sections/map_section.dart';
import 'package:recive/features/home_page/sections/top_news_section.dart';
import 'package:recive/features/home_page/sections/weather_section.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends HookWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      SliverGap(height: 12),
      HomePageCategoriesSection(),
      SliverGap(height: 32),
      HomePageFeaturedEventsSection(),
      SliverGap(height: 32),
      HomePageTopNewsSections(), // Weather Updates
      SliverGap(height: 32),
      HomePageWeatherSection(),
      SliverGap(height: 32),
      HomePageMapSection(),
    ];

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'All you need!',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12).copyWith(bottom: 112),
            sliver: MultiSliver(children: children),
          ),
        ],
      ),
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    required this.onTap,
    required this.constraints,
  });

  final VoidCallback onTap;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: constraints,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.colorScheme.secondary,
        ),
        child: Center(
          child: Text(
            "See More!",
            style: context.textTheme.titleMedium!.copyWith(
              color: context.theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class UserMarker extends StatelessWidget {
  const UserMarker({
    super.key,
    required this.geolocation,
  });

  final Position geolocation;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: geolocation.latLng!,
          width: 80,
          height: 80,
          builder: (context) => LoadingAnimationWidget.beat(
            color: Colors.greenAccent,
            size: 25,
          ),
        ),
      ],
    );
  }
}
