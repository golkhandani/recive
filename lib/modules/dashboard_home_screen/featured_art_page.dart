import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/art_detail_screen/user_interaction_bloc.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/dashboard_home_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/artist_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/event_card_container.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_screen.dart';
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
  late final UserInteractionBloc interactionBloc = BlocProvider.of(context);

  @override
  void initState() {
    bloc.init();
    bloc.subsribe(interactionBloc);
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
      height: context.vTopSafeHeight + kToolbarHeight,
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Vancouver Art Compass',
            style: context.typographyTheme.titleSmall.textStyle.copyWith(
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [PinnedHeaderSliver(child: header)];
      },
      body: BlocBuilder<FeaturedArtBloc, FeaturedArtBlocState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.isLoading == LoadingState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            backgroundColor: context.colorTheme.navBackground,
            color: context.colorTheme.primary,
            displacement: context.vHeight / 20,
            onRefresh: () async {
              Future block = bloc.stream.first;
              await bloc.init(refresh: true);
              await block;
            },
            child: CustomScrollView(
              cacheExtent: 1000,
              slivers: [
                SliverGap(kTinyPadding.bottom),
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
                            "Artwork of the Day:",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kMediumPadding.left,
                          ),
                          child: Builder(builder: (context) {
                            var data = state.dayArt!;
                            return StatefulBuilder(
                              builder: (context, setInnerState) {
                                return ArtCardContainer.big(
                                  hero: HomeScreen.name + data.id,
                                  constraints: BoxConstraints.expand(
                                    width: context.vWidth,
                                    height: context.vWidth,
                                  ),
                                  data: data,
                                  onLikeClicked: (isLiked) {
                                    final updated = data.userInteraction.copyWith(
                                      isLiked: isLiked,
                                    );
                                    setInnerState(() {
                                      data = data.copyWith(userInteraction: updated);
                                    });
                                    interactionBloc.interact(
                                        data.id, EntityType.art, updated);
                                  },
                                  onSaveClicked: (isSaved) {
                                    final updated = data.userInteraction.copyWith(
                                      isSaved: isSaved,
                                    );
                                    setInnerState(() {
                                      data = data.copyWith(userInteraction: updated);
                                    });
                                    interactionBloc.interact(
                                        data.id, EntityType.art, updated);
                                  },
                                  onTap: () {
                                    final current = navigator.homeUrl;
                                    navigator.homeContext.push(
                                      '$current/${ArtDetailScreen.name}/${data.id}',
                                    );
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
                SliverGap(kTinyPadding.bottom),
                if (state.events.isNotEmpty) ...[
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
                                "Upcoming Events:",
                                maxLines: 1,
                                style:
                                    context.typographyTheme.titleTiny.onBackground.textStyle,
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  final homeUrl = navigator.homeUrl;
                                  final extra = SearchScreenFiltersData.none().copyWith(
                                    events: true,
                                    autoSearch: true,
                                  );
                                  navigator.homeContext.push(
                                    '$homeUrl/${SearchScreen.name}',
                                    extra: extra,
                                  );
                                },
                                child: Text(
                                  "View All",
                                  maxLines: 1,
                                  style: context
                                      .typographyTheme.subtitleMedium.primary.textStyle,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.vHeight / 4,
                          child: ListView.separated(
                            clipBehavior: Clip.none,
                            cacheExtent: state.events.length * (context.vWidth / 1.5),
                            padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              var data = state.events[index];
                              return StatefulBuilder(builder: (context, setInnerState) {
                                return EventCardContainer.medium(
                                  data: data,
                                  constraints:
                                      BoxConstraints.expand(width: context.vWidth / 1.5),
                                  onTap: () {
                                    final current = navigator.homeUrl;
                                    navigator.homeContext.push(
                                      '$current/${EventDetailScreen.name}/${data.id}',
                                    );
                                  },
                                  onLikeClicked: (isLiked) {
                                    final updated = data.userInteraction.copyWith(
                                      isLiked: isLiked,
                                    );
                                    setInnerState(() {
                                      data = data.copyWith(userInteraction: updated);
                                    });
                                    interactionBloc.interact(
                                        data.id, EntityType.event, updated);
                                  },
                                  onSaveClicked: (isSaved) {
                                    final updated = data.userInteraction.copyWith(
                                      isSaved: isSaved,
                                    );
                                    setInnerState(() {
                                      data = data.copyWith(userInteraction: updated);
                                    });
                                    interactionBloc.interact(
                                        data.id, EntityType.event, updated);
                                  },
                                );
                              });
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
                ],
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
                              "Meet the Artists:",
                              maxLines: 1,
                              style: context.typographyTheme.titleTiny.onBackground.textStyle,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                final homeUrl = navigator.homeUrl;
                                final extra = SearchScreenFiltersData.none().copyWith(
                                  artists: true,
                                  autoSearch: true,
                                );
                                navigator.homeContext.push(
                                  '$homeUrl/${SearchScreen.name}',
                                  extra: extra,
                                );
                              },
                              child: Text(
                                "View All",
                                maxLines: 1,
                                style:
                                    context.typographyTheme.subtitleMedium.primary.textStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.vWidth / 2.4,
                        child: ListView.separated(
                          clipBehavior: Clip.none,
                          cacheExtent: state.artists.length * (context.vWidth / 2.4),
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
                if (state.featuredArts.isNotEmpty) ...[
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
                                "Art Board:",
                                maxLines: 1,
                                style:
                                    context.typographyTheme.titleTiny.onBackground.textStyle,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kMediumPadding.right - kExtraTinyPadding.right,
                    ),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.featuredArts.take(9).length,
                        (context, index) {
                          var data = state.featuredArts[index];
                          final card =
                              index == 3 ? ArtCardContainer.medium : ArtCardContainer.small;
                          return StatefulBuilder(builder: (context, setInnerState) {
                            return Padding(
                              padding: kExtraTinyPadding,
                              child: card(
                                hero: HomeScreen.name + data.id,
                                constraints: BoxConstraints.expand(
                                  width: context.vWidth - (kMediumPadding.right) * 2,
                                ),
                                onLikeClicked: (isLiked) {
                                  final updated = data.userInteraction.copyWith(
                                    isLiked: isLiked,
                                  );
                                  setInnerState(() {
                                    data = data.copyWith(userInteraction: updated);
                                  });
                                  interactionBloc.interact(data.id, EntityType.art, updated);
                                },
                                onSaveClicked: (isSaved) {
                                  final updated = data.userInteraction.copyWith(
                                    isSaved: isSaved,
                                  );
                                  setInnerState(() {
                                    data = data.copyWith(userInteraction: updated);
                                  });
                                  interactionBloc.interact(data.id, EntityType.art, updated);
                                },
                                data: data,
                                onTap: () {
                                  final current = navigator.homeUrl;
                                  navigator.homeContext.push(
                                    '$current/${ArtDetailScreen.name}/${data.id}',
                                  );
                                },
                              ),
                            );
                          });
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
                          StairedGridTile(1, 2),
                          StairedGridTile(0.5, 1),
                          StairedGridTile(0.5, 1),
                        ],
                      ),
                    ),
                  ),
                  SliverGap(kTinyPadding.bottom),
                ],
                SliverGap(kLargePadding.bottom * 2),
              ],
            ),
          );
        },
      ),
    );
  }
}
