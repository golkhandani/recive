import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/artist_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/category_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/community_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/event_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/news_card_container.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
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
          bottom: kExtraTinyBorder.copyWith(
            color: context.colorTheme.onPrimaryContainer,
          ),
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
            SliverGap(kTinyPadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kTinyPadding.top,
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
                        final data = state.categories[index];
                        return CategoryCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 2.5),
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/${CategoryDetailScreen.name}/${data.id}',
                              extra: data.toJson(),
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
            SliverGap(kTinyPadding.bottom),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.left,
                      vertical: kTinyPadding.top,
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
                    height: context.vHeight / 4,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        final data = state.events[index];
                        return EventCardContainer.medium(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 1.5),
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/${EventDetailScreen.name}/${data.id}',
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
              SliverGap(kTinyPadding.bottom),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kMediumPadding.left,
                        vertical: kTinyPadding.top,
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
                          final data = state.dayArt!;
                          return ArtCardContainer.big(
                            hero: HomeScreen.name + data.id,
                            constraints: BoxConstraints.expand(
                              width: context.vWidth,
                              height: context.vWidth,
                            ),
                            data: data,
                            onTap: () {
                              final current = navigator.homeUrl;
                              navigator.homeContext.push(
                                '$current/${ArtDetailScreen.name}/${data.id}',
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
            SliverGap(kTinyPadding.bottom),
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
                    height: max(context.vHeight / 6, 88),
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        final data = state.news[index];
                        return NewsCardContainer.medium(
                          data: data,
                          constraints: BoxConstraints.expand(
                            width: context.vWidth / 1.6,
                            height: context.vHeight / 8,
                          ),
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/${NewsDetailScreen.name}/${data.id}',
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
            SliverGap(kTinyPadding.bottom),
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
                    final data = state.featuredArts[index];
                    final card =
                        index == 3 ? ArtCardContainer.medium : ArtCardContainer.small;
                    return Padding(
                      padding: kExtraTinyPadding,
                      child: card(
                        hero: HomeScreen.name + data.id,
                        constraints: const BoxConstraints.expand(),
                        data: data,
                        onTap: () {
                          final current = navigator.homeUrl;
                          navigator.homeContext.push(
                            '$current/${ArtDetailScreen.name}/${data.id}',
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
            SliverGap(kTinyPadding.bottom),
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
                        final data = state.artists[index];
                        return ArtistCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 2.4),
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/${ArtistDetailScreen.name}/${data.id}',
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
            SliverGap(kTinyPadding.bottom),
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
                        final data = state.communities[index];
                        return CommunityCardContainer.small(
                          data: data,
                          constraints: BoxConstraints.expand(width: context.vWidth / 1.2),
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/${CommunityDetailScreen.name}/${data.id}',
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
            SliverGap(kLargePadding.bottom * 2),
          ],
        );
      },
    );
  }
}
