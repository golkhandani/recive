import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/modules/home_page/sections/category_section.dart';
import 'package:recive/modules/home_page/sections/featured_section.dart';
import 'package:recive/modules/home_page/sections/map_section.dart';
import 'package:recive/modules/home_page/sections/weather_section.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';

class HomeScreen extends HookWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      SliverGap(height: 12),
      HomePageCategoriesSection(),
      SliverGap(height: 12),
      HomePageFeaturedSection(),
      SliverGap(height: 12),
      HomePageMapSection(),
      SliverGap(height: 12),
      HomePageWeatherSection(),
      // SliverGap(height: 32),
      // HomePageTopNewsSections(), // Weather Updates
    ];

    return ColoredBox(
      color: context.colorScheme.background,
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
