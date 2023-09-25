import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/colored_network_image.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/bookmarks_page/cubits/bookmarks_cubit.dart';
import 'package:recive/features/featured_page/models/art_model.dart';
import 'package:recive/features/near_me_page/cubits/art_detail_cubit.dart';
import 'package:recive/features/search_page/widgets/tag_chip_container.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/utils/share_service.dart';

class ArtDetailScreen extends HookWidget {
  static const name = 'art_datail';
  static const pathParamId = 'id';
  const ArtDetailScreen({
    super.key,
    required this.id,
    required this.extra,
  });

  final String id;
  final ExtraData<ArtDetailSummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<ArtDetailCubit>();
    final state = useBlocBuilder(bloc);
    final bookmarksBloc = context.read<BookmarksCubit>();

    useEffect(() {
      bloc.loadArtById(id);
      return () => bloc.flush();
    }, []);

    final heroTag = extra?.heroTag ?? '';
    final summary = extra?.summary;
    final data = state.nearbyItem;
    final loading = state.loadingState;

    return ColoredBox(
      color: context.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          if (summary != null || data != null) ...[
            ScreenSafeAreaHeader(
              title: (summary?.title ?? data?.title ?? '').dynamicSub(16),
            ),
            SliverPadding(
              padding: kTinyPadding.copyWith(
                bottom: context.footerHeight + 32,
              ),
              sliver: Builder(
                builder: (context) {
                  final isLoading = summary == null &&
                      data == null &&
                      loading != LoadingState.done;

                  if (isLoading) {
                    return kSliverFillLoading;
                  }

                  final infoStyle = context.textTheme.bodyLarge!.copyWith(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  );

                  return MultiSliver(
                    children: [
                      _buildImageCarousel(summary, data, heroTag),
                      const SliverGap(height: 12),
                      Builder(
                        builder: (context) {
                          if (data == null && loading == LoadingState.done) {
                            return kSliverFillLoading;
                          }
                          return MultiSliver(
                            children: [
                              SliverCardContainer(
                                borderRadius: BorderRadius.circular(16),
                                color: context.colorScheme.background,
                                padding: EdgeInsets.zero,
                                sliver: SliverToBoxAdapter(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints:
                                        const BoxConstraints.expand(height: 56),
                                    padding: kTinyPadding,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LikeButton(
                                          padding: EdgeInsets.zero,
                                          size: 42,
                                          onTap: (isLiked) async {
                                            bloc.toggleFavorite(id);
                                            bookmarksBloc.toggleFavorite(
                                              id,
                                              onFailure: () =>
                                                  bloc.toggleFavorite(id),
                                            );
                                            return !isLiked;
                                          },
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor:
                                                context.colorScheme.primary,
                                            dotSecondaryColor:
                                                context.colorScheme.secondary,
                                          ),
                                          isLiked: state.isBookmarked,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          likeBuilder: (isLiked) => Icon(
                                            isLiked
                                                ? Icons.bookmark_rounded
                                                : Icons.bookmark_border_rounded,
                                            size: 42,
                                            color:
                                                context.colorScheme.onSurface,
                                          ),
                                        ),
                                        LikeButton(
                                          padding: EdgeInsets.zero,
                                          size: 42,
                                          onTap: (isLiked) async {
                                            return !isLiked;
                                          },
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor:
                                                context.colorScheme.primary,
                                            dotSecondaryColor: Colors.redAccent,
                                          ),
                                          likeBuilder: (isLiked) => Icon(
                                            isLiked
                                                ? Icons.favorite_rounded
                                                : Icons.favorite_border_rounded,
                                            size: 50,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            Icons.ios_share,
                                            size: 42,
                                            color:
                                                context.colorScheme.onSurface,
                                          ),
                                          onPressed: () {
                                            locator
                                                .get<ShareService>()
                                                .shareArt(
                                                  context,
                                                  title: data?.title ?? '',
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              _buildTitleInfo(summary, data),
                              const SliverGap(height: 12),
                              _buildBasicInfo(data, infoStyle),
                              const SliverGap(height: 12),
                              _buildOrganizerInfo(data, infoStyle),
                              const SliverGap(height: 12),
                              _buildTagInfo(data),
                              const SliverGap(height: 12),
                              _buildSourceInfo(data, infoStyle),
                            ],
                          );
                        },
                      ),
                      const SliverGap(height: 12),
                    ],
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildImageCarousel(
      ArtDetailSummaryData? summary, ArtModel? data, String heroTag) {
    return CardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: kTinyPadding,
      child: LayoutBuilder(builder: (context, box) {
        if ((summary?.imageUrl ?? data!.images.firstOrNull?.imageUrl) == null) {
          return const SizedBox();
        }

        // Warning: To stop rebuild issue
        // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
        final list = [
          summary?.imageUrl ?? data!.images.first.imageUrl,
          ...(data?.images.map((e) => e.imageUrl).toList() ??
              // TO FIX THE ISSUE WITH SAME HERO TAG
              [
                summary?.imageUrl ?? data!.images.first.imageUrl,
                summary?.imageUrl ?? data!.images.first.imageUrl,
              ])
        ].mapIndexed((index, data) {
          final item = ColoredNetworkImage(
            imageUrl: data,
            constraints: const BoxConstraints.expand(height: 240),
            color: Colors.blueGrey,
          );
          if (index == 0) {
            return Hero(
              tag: heroTag,
              child: item,
            );
          }
          return item;
        }).toList();

        return CarouselSlider(
          items: list,
          options: CarouselOptions(
            height: 360,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.24,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }

  Builder _buildSourceInfo(ArtModel? data, TextStyle infoStyle) {
    return Builder(
      key: GlobalKey(debugLabel: 'SOURCE INFO'),
      builder: (context) {
        final color = context.colorScheme.secondary;
        final fontColor = context.colorScheme.onSecondary;
        return SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          color: color,
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              padding: kTinyPadding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        FluentIcons.info_12_regular,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Source : '),
                              if (data?.source.name != null)
                                TextSpan(
                                  text: data?.source.name,
                                ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle.withColor(fontColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        FluentIcons.web_asset_16_regular,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Source URL : '),
                              if (data?.source.copyRight != null)
                                TextSpan(
                                  text: data?.source.copyRight,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(
                                        data!.source.copyRight,
                                      ));
                                    },
                                  style: infoStyle.copyWith(
                                    color: fontColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                          style: infoStyle.withColor(fontColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Builder _buildTagInfo(ArtModel? data) {
    return Builder(
      key: GlobalKey(debugLabel: 'TAG INFO'),
      builder: (context) {
        final color = context.theme.colorScheme.surface;
        final tags = data?.tags ?? [];
        return SliverToBoxAdapter(
          child: CardContainer(
            borderRadius: BorderRadius.circular(16),
            color: color,
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                direction: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                spacing: 4,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                  tags.length,
                  (index) => TagChipContainer(
                    onTap: () {
                      locator.logger.d('on tap tags ${tags[index]}');
                    },
                    tag: tags[index],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Builder _buildOrganizerInfo(ArtModel? data, TextStyle infoStyle) {
    return Builder(
      key: GlobalKey(debugLabel: 'ORGANIZER INFO'),
      builder: (context) {
        final color = context.theme.colorScheme.surface;
        final fontColor = context.theme.colorScheme.onSurface;
        return SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          color: color,
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              padding: kTinyPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FluentIcons.briefcase_12_regular,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Organizer : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.artists.firstOrNull?.name != null)
                                TextSpan(text: data?.artists.firstOrNull?.name),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle.withColor(fontColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        FluentIcons.group_20_regular,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Bio : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.artists.firstOrNull?.biography != null)
                                TextSpan(
                                    text: data?.artists.firstOrNull?.biography),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle.withColor(fontColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FluentIcons.web_asset_16_regular,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Website : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.artists.firstOrNull?.website != null)
                                TextSpan(
                                  text: data?.artists.firstOrNull?.website,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(
                                        data!.artists.firstOrNull!.website,
                                      ));
                                    },
                                  style: infoStyle.copyWith(
                                    color: fontColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                          style: infoStyle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Builder _buildBasicInfo(ArtModel? data, TextStyle infoStyle) {
    return Builder(
        key: GlobalKey(debugLabel: 'BASIC INFO'),
        builder: (context) {
          final color = context.theme.colorScheme.surface;
          final fontColor = context.theme.colorScheme.onSurface;
          if (data == null) {
            return kSliverFillLoading;
          }
          return SliverCardContainer(
            borderRadius: BorderRadius.circular(16),
            color: color,
            padding: kTinyPadding,
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: color,
                ),
                padding: kTinyPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        data.description,
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: fontColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          LineIcons.addressCard,
                          color: fontColor,
                          size: 36,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            data.location.venue.address.localizedAddressDisplay,
                            overflow: TextOverflow.fade,
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: fontColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Builder _buildTitleInfo(
    ArtDetailSummaryData? summary,
    ArtModel? data,
  ) {
    return Builder(
        key: GlobalKey(debugLabel: 'TITLE INFO'),
        builder: (context) {
          final title = summary?.title ?? data?.title;
          if (title == null) {
            return kSliverFillLoading;
          }
          return SliverCardContainer(
            borderRadius: BorderRadius.circular(16),
            color: context.colorScheme.background,
            padding: EdgeInsets.zero,
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // color: context.theme.colorScheme.secondary,
                ),
                padding: kTinyPadding,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: context.titleLargeOnPrimaryContainer.withColor(
                          context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
