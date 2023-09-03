import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/home_page/sections/category_section.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/features/home_page/sections/map_section.dart';
import 'package:recive/features/home_page/sections/top_news_section.dart';
import 'package:recive/features/home_page/sections/weather_section.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends HookWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      SliverGap(height: 12),
      HomePageFeaturedEventsSection(),
      SliverGap(height: 32),
      HomePageCategoriesSection(),
      SliverGap(height: 32),
      HomePageWeatherSection(),
      SliverGap(height: 32),
      HomePageTopNewsSections(), // Weather Updates
      SliverGap(height: 32),
      HomePageMapSection(),
    ];

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'All you need!',
          ),
          SliverPadding(
            padding: kTinyPadding.copyWith(bottom: 112),
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
