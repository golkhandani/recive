import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_screen.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/dashboard_screen.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/artist_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/category_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/community_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/event_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/news_card_container.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = locator.get<FeaturedArtBloc>();
  final navigator = locator.get<NavigationService>();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
        border: Border(
          bottom: BorderSide(color: context.colorTheme.onPrimaryContainer),
        ),
      ),
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Hand picked for you!',
            style: context.typographyTheme.titleSmall.textStyle.copyWith(
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
    return BlocBuilder<FeaturedArtBloc, FeaturedArtBlocState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.isLoading == LoadingState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
          slivers: [
            PinnedHeaderSliver(child: header),
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Explore Art Categories",
                          maxLines: 1,
                          style: context.typographyTheme.titleTiny.onBackground.textStyle,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            "View All",
                            maxLines: 1,
                            style: context.typographyTheme.subtitleMedium.primary.textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.vHeight / 10,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final data = CategoryCardContainerData.fromAbstractCategory(
                          state.categories[index],
                        );
                        return CategoryCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 2.5),
                          onTap: () {
                            navigator.homeContext.go(
                              '/${DashboardScreen.name}/${HomeScreen.name}/${CategoryDetailScreen.name}/${data.id}',
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: kTinyPadding.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Upcoming Events!",
                          maxLines: 1,
                          style: context.typographyTheme.titleTiny.onBackground.textStyle,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            "View All",
                            maxLines: 1,
                            style: context.typographyTheme.subtitleMedium.primary.textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.vHeight / 5,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        final data = EventCardContainerData.fromAbstractEvent(
                          state.events[index],
                        );
                        return EventCardContainer.medium(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 1.5),
                          onTap: () {
                            navigator.homeContext.go(
                              '/${DashboardScreen.name}/${HomeScreen.name}/${EventDetailScreen.name}/${data.id}',
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: kTinyPadding.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.dayArt != null) ...[
              SliverGap(kLargePadding.bottom),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kMediumPadding.left,
                        vertical: kMediumPadding.top,
                      ),
                      child: Text(
                        "Artwork of the Day!",
                        maxLines: 1,
                        style: context.typographyTheme.titleTiny.onBackground.textStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kMediumPadding.left,
                      ),
                      child: Builder(
                        builder: (context) {
                          final data = ArtCardContainerData.fromAbstractArt(
                            state.dayArt!,
                          );
                          return ArtCardContainer.big(
                            hero: HomeScreen.name + data.id,
                            constraints: BoxConstraints.expand(
                              width: context.vWidth,
                              height: context.vWidth,
                            ),
                            data: data,
                            onTap: () {
                              navigator.homeContext.go(
                                '/${DashboardScreen.name}/${HomeScreen.name}/${ArtDetailScreen.name}/${data.id}',
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Latest Art News!",
                          maxLines: 1,
                          style: context.typographyTheme.titleTiny.onBackground.textStyle,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            "View All",
                            maxLines: 1,
                            style: context.typographyTheme.subtitleMedium.primary.textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.vHeight / 4,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final data = NewsCardContainerData.fromAbstractArt(
                          state.news[index],
                        );
                        return NewsCardContainer(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 1.6),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: kTinyPadding.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Text(
                      "Popular in community!",
                      maxLines: 1,
                      style: context.typographyTheme.titleTiny.onBackground.textStyle,
                    ),
                  )
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: kMediumPadding.right - kExtraTinyPadding.right,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.featuredArts.take(6).length,
                  (context, index) {
                    final data = ArtCardContainerData.fromAbstractArt(
                      state.featuredArts[index],
                    );
                    return Padding(
                      padding: kExtraTinyPadding,
                      child: ArtCardContainer.medium(
                        hero: HomeScreen.name + data.id,
                        constraints: const BoxConstraints.expand(),
                        data: data,
                        onTap: () {
                          navigator.homeContext.go(
                            '/${DashboardScreen.name}/${HomeScreen.name}/${ArtDetailScreen.name}/${data.id}',
                          );
                        },
                      ),
                    );
                  },
                ),
                gridDelegate: SliverStairedGridDelegate(
                  startCrossAxisDirectionReversed: false,
                  pattern: const [
                    StairedGridTile(1, 2),
                    StairedGridTile(0.5, 1),
                    StairedGridTile(0.5, 1),
                    StairedGridTile(1, 1),
                    StairedGridTile(0.6, 1),
                    StairedGridTile(0.4, 0.665),
                  ],
                ),
              ),
            ),
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Meet the Artists!",
                          maxLines: 1,
                          style: context.typographyTheme.titleTiny.onBackground.textStyle,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            "View All",
                            maxLines: 1,
                            style: context.typographyTheme.subtitleMedium.primary.textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.vWidth / 2.4,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.artists.length,
                      itemBuilder: (context, index) {
                        final data = ArtistCardContainerData.fromAbstractArtist(
                          state.artists[index],
                        );
                        return ArtistCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 2.4),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: kTinyPadding.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGap(kLargePadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kMediumPadding.top,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Join Our Community!",
                          maxLines: 1,
                          style: context.typographyTheme.titleTiny.onBackground.textStyle,
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Text(
                            "View All",
                            maxLines: 1,
                            style: context.typographyTheme.subtitleMedium.primary.textStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.vWidth / 1.2,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.communities.length,
                      itemBuilder: (context, index) {
                        final data = CommunityCardContainerData.fromAbstractCommunity(
                          state.communities[index],
                        );
                        return CommunityCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 1.2),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: kTinyPadding.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverGap(kLargePadding.bottom * 2),
          ],
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.items = const [],
  });

  final List<ArtAbstractModel> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          return Card(
            color: colorScheme.onSecondary,
            child: ListTile(
              textColor: colorScheme.secondary,
              title: Text(item.title),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
