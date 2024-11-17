import 'dart:io';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/extensions/string_color_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/art_detail_screen/detail_art_bloc.dart';
import 'package:art_for_all/modules/art_detail_screen/widgets/tag_chip.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/artist_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/event_card_container.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/utils/afa_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchMap(double latitude, double longitude) async {
  Uri uri;

  if (Platform.isAndroid) {
    uri = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude');
  } else {
    uri = Uri.parse('comgooglemaps://?q=$latitude,$longitude');
  }

  final fallbackUri = Uri(
    scheme: "https",
    host: "maps.google.com",
    queryParameters: {'q': '$latitude, $longitude'},
  );

  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(fallbackUri);
    }
  } catch (e) {
    await launchUrl(fallbackUri);
    debugPrint(e.toString());
  }
}

class ArtDetailScreen extends StatefulWidget {
  static String name = 'art-detail-screen';
  static String pathParamId = 'artId';

  final String id;
  final ExtraData<ArtAbstractModel>? extra;

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
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          data.title,
                          style: context
                              .typographyTheme.titleMedium.onPrimaryContainer.textStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        "Type: \t${data.artType.capitalize}",
                        style: context.typographyTheme.titleTiny.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        "Description: ",
                        style: context.typographyTheme.titleTiny.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kSmallPadding.bottom),
                      Center(
                        child: Text(
                          data.description,
                          textAlign: TextAlign.start,
                          style: context.typographyTheme.bodyLarge.textStyle
                              .copyWith(color: fontColor),
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        "Location: \n${data.location}",
                        style: context.typographyTheme.titleTiny.onBackground.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      AFAElevatedButton(
                        constraints: BoxConstraints(minWidth: context.vWidth),
                        background: context.colorTheme.primary,
                        child: Text(
                          'Find on map',
                          style: context.typographyTheme.subtitleMedium.onPrimary.textStyle,
                        ),
                        onPressed: () async {
                          launchMap(data.geoLocation.latitude, data.geoLocation.longitude);
                        },
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        "Updated At: \t${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                        style: context
                            .typographyTheme.subtitleMedium.onPrimaryContainer.textStyle,
                      ),
                      Gap(kMediumPadding.bottom),
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
                                        context.typographyTheme.bodySmall.primary.textStyle,
                                  ),
                                ],
                              ),
                              style: context.typographyTheme.subtitleMedium.onPrimaryContainer
                                  .textStyle,
                            ),
                          );
                        },
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
                        height: context.vWidth / 2,
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
                                constraints: BoxConstraints.expand(width: context.vWidth / 2),
                                onTap: () {
                                  final homeUrl = navigator.homeUrl;
                                  navigator.homeContext.push(
                                    '$homeUrl/${ArtistDetailScreen.name}/${artist.id}',
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
                      if (state.events.isNotEmpty) ...[
                        SizedBox(height: kMediumPadding.bottom),
                        Row(
                          children: [
                            Text(
                              "Related Events:",
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
                              itemCount: state.events.length,
                              itemBuilder: (context, index) {
                                final data = state.events[index];
                                return EventCardContainer.medium(
                                  data: data,
                                  constraints:
                                      BoxConstraints.expand(width: context.vWidth / 1.2),
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
                      ],
                      if (state.similarArts.isNotEmpty) ...[
                        SizedBox(height: kMediumPadding.bottom),
                        Row(
                          children: [
                            Text(
                              "Similar Arts:",
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
                              itemCount: state.similarArts.length,
                              itemBuilder: (context, index) {
                                final data = state.similarArts[index];
                                return ArtCardContainer.medium(
                                  data: data,
                                  constraints:
                                      BoxConstraints.expand(width: context.vWidth / 1.6),
                                  onTap: () {
                                    final homeUrl = navigator.homeUrl;
                                    navigator.homeContext.push(
                                      '$homeUrl/${ArtDetailScreen.name}/${data.id}',
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
                      ],
                      Gap(kMediumPadding.bottom),
                      Row(
                        children: [
                          Text(
                            "Tags:",
                            maxLines: 1,
                            style: context.typographyTheme.titleTiny.onBackground.textStyle,
                          ),
                          const Spacer(),
                        ],
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

  bool _favorite = false;
  bool _bookmark = false;

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.vHeight / 2.2;
    final backgroundColor = context.colorTheme.primaryContainer;
    final actions = [
      GestureDetector(
        onTap: () {
          setState(() {
            _favorite = !_favorite;
          });
        },
        child: Icon(
          _favorite ? Icons.favorite : Icons.favorite_outline,
          color: context.colorTheme.error,
          size: kToolbarHeight / 2,
        ),
      ),
      SizedBox(width: kTinyPadding.right),
      GestureDetector(
        onTap: () {
          setState(() {
            _bookmark = !_bookmark;
          });
        },
        child: Icon(
          _bookmark ? Icons.bookmark : Icons.bookmark_outline,
          color: context.colorTheme.success,
          size: kToolbarHeight / 2,
        ),
      ),
      SizedBox(width: kTinyPadding.right),
      GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.share_outlined,
          color: context.colorTheme.onBackground,
          size: kToolbarHeight / 2,
        ),
      ),
      SizedBox(width: kTinyPadding.right),
    ];
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
      actions: actions,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final flexHeight = constraints.maxHeight - context.vTopSafeHeight - kToolbarHeight;
          final scale = flexHeight / maxHeight;
          final media = widget.art.media
              .map((m) => ZoomImage(media: m, constraints: constraints))
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
                child: Container(
                  width: context.vWidth,
                  padding: EdgeInsets.only(
                    top: (context.vTopSafeHeight - kToolbarHeight).clamp(0, kToolbarHeight),
                    right: (kToolbarHeight / 2) * (actions.length - 2),
                    left: kToolbarHeight + kMediumPadding.right,
                  ),
                  child: Text(
                    widget.art.title + widget.art.title,
                    textAlign: TextAlign.left,
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
                        enableInfiniteScroll: media.length > 2,
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
