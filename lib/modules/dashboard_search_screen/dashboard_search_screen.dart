import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/dropdown/async_search_field.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_bloc.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  static const String name = 'search';
  const SearchScreen({
    super.key,
    this.filtersData = const SearchScreenFiltersData(),
    this.isViewAll = false,
  });

  final SearchScreenFiltersData filtersData;
  final bool isViewAll;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final bloc = locator.get<DashboardSearchBloc>();
  final navigator = locator.get<NavigationService>();

  final filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bloc.init(widget.filtersData, widget.isViewAll);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final font = context.typographyTheme.subtitleMedium.onPrimary.textStyle;
    final Widget header = Container(
      decoration: BoxDecoration(
        color: context.colorTheme.primaryContainer,
      ),
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
    );
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocConsumer<DashboardSearchBloc, DashboardSearchBlocState>(
        listener: (context, state) {},
        bloc: bloc,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              PinnedHeaderSliver(child: header),
              PinnedHeaderSliver(
                child: Container(
                  padding: kMediumPadding.copyWith(
                    left: widget.isViewAll ? 0 : kMediumPadding.left,
                  ),
                  color: context.colorTheme.primaryContainer,
                  child: Row(
                    children: [
                      if (widget.isViewAll)
                        LeadingBackButton(
                            backgroundColor: context.colorTheme.primaryContainer),
                      Expanded(
                        child: AsyncSearchField<String>(
                          hintText: 'Search...',
                          items: const [],
                          onChanged: bloc.search,
                          controller: filterController,
                          isLoading: false,
                          isEnabled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PinnedHeaderSliver(
                child: Container(
                  color: context.colorTheme.primaryContainer,
                  constraints: BoxConstraints(
                    maxHeight: font.fontSize! * (font.height ?? 1.2) + kMediumPadding.top * 2,
                  ),
                  child: OverflowBox(
                    maxWidth: context.vWidth,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: kMediumPadding.right),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final text = state.keywords[index];
                        return InkWell(
                          onTap: () {
                            filterController.text = text;
                          },
                          borderRadius: kSmallBorderRadius,
                          child: Container(
                            padding: kSmallPadding,
                            decoration: BoxDecoration(
                              color: context.colorTheme.primary,
                              borderRadius: kSmallBorderRadius,
                            ),
                            child: Center(
                              child: Text(
                                text,
                                style: context
                                    .typographyTheme.subtitleMedium.onPrimary.textStyle,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: kTinyPadding.right),
                      itemCount: state.keywords.length,
                    ),
                  ),
                ),
              ),
              PinnedHeaderSliver(
                child: Container(
                  padding: EdgeInsets.only(top: kTinyPadding.top),
                  decoration: BoxDecoration(
                    color: context.colorTheme.primaryContainer,
                    border: Border(
                      bottom: kExtraTinyBorder.copyWith(
                        color: context.colorTheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  if (state.isLoading == LoadingState.loading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.result.isEmpty) {
                    return SliverFillRemaining(
                      fillOverscroll: true,
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: context.colorTheme.onBackground,
                              size: context.vWidth / 10,
                            ),
                            Text(
                              "There is no result!",
                              style: context.typographyTheme.onBackground.titleTiny.textStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverList.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      final data = state.result[index];
                      final page = switch (data.searchType) {
                        SearchType.art => ArtDetailScreen.name,
                        SearchType.artist => ArtistDetailScreen.name,
                        SearchType.news => NewsDetailScreen.name,
                        SearchType.event => EventDetailScreen.name,
                        SearchType.community => CommunityDetailScreen.name,
                      };
                      return Container(
                        margin: EdgeInsets.only(
                          right: kMediumPadding.right,
                          left: kMediumPadding.left,
                          bottom: kMediumPadding.bottom,
                          top: index == 0 ? kMediumPadding.top : 0,
                        ),
                        child: SearchResultCardContainer(
                          onTap: () {
                            final current = navigator.homeUrl;
                            navigator.homeContext.push(
                              '$current/$page/${data.id}',
                              extra: data.toJson(),
                            );
                          },
                          data: data,
                        ),
                      );
                    },
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}

class SearchResultCardContainer extends StatelessWidget {
  const SearchResultCardContainer({
    super.key,
    required this.data,
    required this.onTap,
  });

  final VoidCallback onTap;
  final SearchAbstractModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: context.vHeight / 10,
            width: context.vWidth / 4,
            child: CachedNetworkImage(
              imageUrl: data.imageUrl,
              imageBuilder: (context, imageProvider) => Material(
                elevation: 1,
                borderRadius: kSmallBorderRadius,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      opacity: 0.9,
                    ),
                    borderRadius: kSmallBorderRadius,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: kMediumPadding.right),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kExtraTinyPadding.bottom),
                Text(
                  data.searchType.name.toUpperCase(),
                  style: context.typographyTheme.subtitleSmall.onBackground.textStyle,
                ),
                SizedBox(height: kExtraTinyPadding.bottom),
                Text(
                  data.title,
                  style: context.typographyTheme.titleSmall.onBackground.textStyle,
                ),
                SizedBox(height: kExtraTinyPadding.bottom),
                Text(
                  data.tags.take(3).join(', '),
                  style: context.typographyTheme.subtitleMedium.onBackground.textStyle,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
