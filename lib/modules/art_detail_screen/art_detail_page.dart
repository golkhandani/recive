import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/art_detail_screen/detail_art_bloc.dart';
import 'package:art_for_all/modules/art_detail_screen/widgets/tag_chip.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/artist_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/community_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/event_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/news_card_container.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtDetailScreen extends StatefulWidget {
  static String name = 'art-detail-screen';
  static String pathParamId = 'artId';

  final String id;
  final ExtraData<ArtDetailSummaryData>? extra;

  const ArtDetailScreen({super.key, required this.id, this.extra});

  @override
  State<ArtDetailScreen> createState() => _ArtDetailScreenState();
}

class _ArtDetailScreenState extends State<ArtDetailScreen> {
  final carouselController = CarouselController(initialItem: 0);
  final bloc = locator.get<DetailArtBloc>();
  final navigator = locator.get<NavigationService>();

  @override
  void initState() {
    bloc.init(widget.id, null);
    super.initState();
  }

  @override
  void dispose() {
    bloc.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<DetailArtBloc, DetailArtBlocState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.isLoadingArt == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.art == null) {
            return const SizedBox();
          }

          final data = state.art!;
          final fontColor = context.colorTheme.onSurface;
          return ColoredBox(
            color: context.colorTheme.surface,
            child: CustomScrollView(slivers: [
              ArtDetailHeader(art: data),
              SliverToBoxAdapter(
                child: Padding(
                  padding: kMediumPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: context.typographyTheme.titleTiny.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: context
                            .typographyTheme.subtitleMedium.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        data.artType.toUpperCase(),
                        style: context.typographyTheme.titleTiny.onPrimaryContainer.textStyle,
                      ),
                      Gap(kMediumPadding.bottom),
                      Center(
                        child: Text(
                          data.description,
                          textAlign: TextAlign.start,
                          style: context.typographyTheme.bodyLarge.textStyle
                              .copyWith(color: fontColor),
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Row(
                        children: [
                          Text(
                            "Artists",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: kExtraTinyPadding.bottom),
                      SizedBox(
                        height: context.vWidth / 4,
                        child: OverflowBox(
                          maxWidth: context.vWidth,
                          child: ListView.separated(
                            clipBehavior: Clip.none,
                            padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.artists.length,
                            itemBuilder: (context, index) {
                              final artist = data.artists[index];
                              return ArtistCardContainer.small(
                                data: artist,
                                constraints: BoxConstraints.expand(width: context.vWidth / 4),
                                onTap: () {
                                  final homeUrl = navigator.homeUrl;
                                  navigator.homeContext.push(
                                    '$homeUrl/${ArtistDetailScreen.name}/${data.id}',
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: kTinyPadding.left,
                            ),
                          ),
                        ),
                      ),
                      Gap(kMediumPadding.bottom),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          direction: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          spacing: 4,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: List.generate(
                            data.tags.length,
                            (index) => TagChipContainer(
                              onTap: () {},
                              tag: data.tags[index],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      CommunityCardContainer.big(
                        data: data.community,
                        constraints: BoxConstraints(
                          maxHeight: context.vHeight / 3,
                          maxWidth: context.vWidth,
                        ),
                        onTap: () {
                          final homeUrl = navigator.homeUrl;
                          navigator.homeContext.push(
                            '$homeUrl/${CommunityDetailScreen.name}/${data.id}',
                          );
                        },
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Row(
                        children: [
                          Text(
                            "Links",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: kTinyPadding.bottom),
                      ...data.links.map(
                        (l) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: kSmallPadding.bottom),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "${l.title}: "),
                                  TextSpan(
                                    text: l.url,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(l.url));
                                      },
                                    style:
                                        context.typographyTheme.bodyMedium.primary.textStyle,
                                  ),
                                ],
                              ),
                              style: context
                                  .typographyTheme.bodySmall.onPrimaryContainer.textStyle,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Row(
                        children: [
                          Text(
                            "Related Events!",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: kExtraTinyPadding.bottom),
                      SizedBox(
                        height: context.vHeight / 6,
                        child: OverflowBox(
                          maxWidth: context.vWidth,
                          child: ListView.separated(
                            clipBehavior: Clip.none,
                            padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.events.length,
                            itemBuilder: (context, index) {
                              final data = state.events[index];
                              return EventCardContainer.medium(
                                data: data,
                                constraints:
                                    BoxConstraints.expand(width: context.vWidth / 1.6),
                                onTap: () {
                                  final homeUrl = navigator.homeUrl;
                                  navigator.homeContext.push(
                                    '$homeUrl/${EventDetailScreen.name}/${data.id}',
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: kTinyPadding.left,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Row(
                        children: [
                          Text(
                            "Related News!",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: kExtraTinyPadding.bottom),
                      SizedBox(
                        height: context.vHeight / 4,
                        child: OverflowBox(
                          maxWidth: context.vWidth,
                          child: ListView.separated(
                            clipBehavior: Clip.none,
                            padding: EdgeInsets.symmetric(horizontal: kMediumPadding.left),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.news.length,
                            itemBuilder: (context, index) {
                              final data = state.news[index];
                              return NewsCardContainer.medium(
                                data: data,
                                constraints:
                                    BoxConstraints.expand(width: context.vWidth / 1.6),
                                onTap: () {
                                  final homeUrl = navigator.homeUrl;
                                  navigator.homeContext.push(
                                    '$homeUrl/${NewsDetailScreen.name}/${data.id}',
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: kTinyPadding.left,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: kLargePadding.bottom),
                    ],
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}

class ArtDetailHeader extends StatefulWidget {
  const ArtDetailHeader({
    super.key,
    required this.art,
  });

  final ArtModel art;

  @override
  State<ArtDetailHeader> createState() => _ArtDetailHeaderState();
}

class _ArtDetailHeaderState extends State<ArtDetailHeader> {
  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 48,
        width: 48,
        child: CircularProgressIndicator(),
      ),
    );
  }

  double heroOpacity = 1;

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.vHeight / 2.4;
    final backgroundColor = context.colorTheme.primaryContainer;
    return SliverAppBar(
      backgroundColor: backgroundColor,
      expandedHeight: maxHeight,
      collapsedHeight: kToolbarHeight,
      toolbarHeight: kToolbarHeight,
      floating: false,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: kToolbarHeight + kTinyPadding.right,
      leading: LeadingBackButton(backgroundColor: backgroundColor),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final flexHeight = constraints.maxHeight - context.vTopSafeHeight - kToolbarHeight;
          final scale = flexHeight / maxHeight;
          final media = widget.art.media
              .map(
                (m) => CachedNetworkImage(
                  imageUrl: m.url,
                  imageBuilder: (context, imageProvider) => Container(
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        opacity: 1,
                      ),
                      color: context.colorTheme.primaryContainer,
                      borderRadius: kMediumBorderRadius,
                    ),
                  ),
                  placeholder: (context, url) => _buildLoading(),
                  // errorWidget: (context, url, error) => _buildCard(null, color, child),
                ),
              )
              .toList();
          return Container(
            decoration: BoxDecoration(
              color: context.colorTheme.primaryContainer,
              border: Border(
                bottom: kExtraTinyBorder.copyWith(
                  color: context.colorTheme.onPrimaryContainer,
                ),
              ),
            ),
            child: FlexibleSpaceBar(
              expandedTitleScale: 1,
              collapseMode: CollapseMode.parallax,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: 1 - scale == 1 ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kToolbarHeight,
                  ).copyWith(
                    top: kToolbarHeight,
                  ),
                  child: Text(
                    widget.art.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: context.typographyTheme.titleSmall.onPrimaryContainer.textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: widget.art.media.first.url,
                      imageBuilder: (context, imageProvider) => Container(
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            opacity: 0.3,
                          ),
                          color: context.colorTheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: kToolbarHeight + context.vTopSafeHeight,
                    bottom: kMediumPadding.bottom,
                    child: CarouselSlider.builder(
                      itemCount: media.length,
                      itemBuilder: (context, index, pageViewIndex) {
                        final child = media[index];
                        return child;
                      },
                      options: CarouselOptions(
                        padEnds: true,
                        onPageChanged: (index, reason) {},
                        viewportFraction: 0.8,
                        enlargeFactor: 0.2,
                        height: maxHeight - kToolbarHeight,
                        enlargeCenterPage: true,
                        clipBehavior: Clip.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
