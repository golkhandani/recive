import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/home_page/sections/weather_section.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends HookWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            sliver: MultiSliver(
              children: [
                const SliverGap(height: 12),
                const HomePageCategoriesSection(),
                const SliverGap(height: 32),
                const HomePageWeatherSection(),
                const SliverGap(height: 32),
                const HomePageFeaturedEventsSection(),
                const SliverGap(height: 32),
                HomePageTopNewsSections(), // Weather Updates

                const SliverGap(height: 32),
                MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: Text(
                      "City Highlights (Map)",
                      style: context.textTheme.headlineSmall,
                    ),
                  ),
                  const SliverGap(height: 12),
                  SliverCardContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.all(12),
                    sliver: SliverLayoutBuilder(builder: (context, sliver) {
                      return SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                          width: sliver.asBoxConstraints().maxWidth,
                          height: sliver.asBoxConstraints().maxWidth,
                        ),
                      );
                    }),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePageTopNewsSections extends HookWidget {
  const HomePageTopNewsSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Top News Stories",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverLayoutBuilder(builder: (context, sliver) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 11,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => index == 10
                      ? InkWell(
                          onTap: () =>
                              navigationService.navigateTo(NewsScreen.name),
                          child: Container(
                            width: sliver.asBoxConstraints().maxWidth / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.theme.colorScheme.secondary,
                            ),
                            child: Center(
                              child: Text(
                                "See More!",
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: context
                                      .theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => navigationService
                              .navigateTo(DetailScreen.name, pathParameters: {
                            DetailScreen.pathParamId: index.toString(),
                            DetailScreen.pathParamType: DetailType.news.name
                          }),
                          child: Container(
                            width: sliver.asBoxConstraints().maxWidth / 1.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class HomePageFeaturedEventsSection extends HookWidget {
  const HomePageFeaturedEventsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Featured Events",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: MultiSliver(
            children: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: 4,
                  (context, index) => index == 3
                      ? InkWell(
                          onTap: () =>
                              navigationService.navigateTo(FeaturedScreen.name),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.theme.colorScheme.secondary,
                            ),
                            child: Center(
                              child: Text(
                                "See More!",
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: context
                                      .theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => navigationService
                              .navigateTo(DetailScreen.name, pathParameters: {
                            DetailScreen.pathParamId: index.toString(),
                            DetailScreen.pathParamType: DetailType.event.name
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.amber,
                            ),
                          ),
                        ),
                ),
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  repeatPattern: QuiltedGridRepeatPattern.same,
                  pattern: const [
                    QuiltedGridTile(3, 4),
                    QuiltedGridTile(3, 2),
                    QuiltedGridTile(2, 2),
                    QuiltedGridTile(1, 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomePageCategoriesSection extends HookWidget {
  const HomePageCategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Event Categories",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverLayoutBuilder(builder: (context, sliver) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 76,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 11,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => index == 10
                      ? InkWell(
                          onTap: () => navigationService
                              .navigateTo(CategoriesScreen.name),
                          child: Container(
                            width: sliver.asBoxConstraints().maxWidth / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.theme.colorScheme.secondary,
                            ),
                            child: Center(
                              child: Text(
                                "See More!",
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: context
                                      .theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => navigationService
                              .navigateTo(DetailScreen.name, pathParameters: {
                            DetailScreen.pathParamId: index.toString(),
                            DetailScreen.pathParamType: DetailType.category.name
                          }),
                          child: Container(
                            width: sliver.asBoxConstraints().maxWidth / 1.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
