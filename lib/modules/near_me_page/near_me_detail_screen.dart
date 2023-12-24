import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/bookmarks/cubits/bookmarks_cubit.dart';
import 'package:recive/modules/featured_page/models/art_model.dart';
import 'package:recive/modules/near_me_page/cubits/art_detail_cubit.dart';
import 'package:recive/modules/near_me_page/widgets/hero_image_gallery.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/string_extensions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/utils/share_service.dart';

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
      color: context.colorTheme.background,
      child: CustomScrollView(
        slivers: [
          if (summary != null || data != null) ...[
            ScreenSafeAreaHeader(
              title: (summary?.title ?? data?.title ?? '').dynamicSub(20),
              elevation: false,
            ),
            SliverPadding(
              padding: kTinyPadding.copyWith(
                bottom: context.footerHeight + 32,
              ),
              sliver: Builder(
                builder: (context) {
                  final isLoading = summary == null && data == null && loading != LoadingState.done;

                  if (isLoading) {
                    return kSliverFillAnimatedLoading;
                  }

                  final infoStyle = context.textTheme.bodyMedium.onPrimaryContainer.style;

                  return MultiSliver(
                    children: [
                      HeroImageGallery(
                        heroImage: summary?.imageUrl,
                        images: data?.images ?? [],
                        heroTag: heroTag,
                      ),
                      const SliverGap(height: 12),
                      if (data == null || loading == LoadingState.loading)
                        kSkeletonSectionLoadingBox
                      else
                        MultiSliver(
                          children: [
                            SliverCardContainer(
                              borderRadius: kMediumBorderRadius,
                              color: context.colorTheme.background,
                              padding: EdgeInsets.zero,
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: kSmallBorderRadius,
                                  ),
                                  constraints: const BoxConstraints.expand(height: 56),
                                  padding: kTinyPadding,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      LikeButton(
                                        padding: EdgeInsets.zero,
                                        size: 42,
                                        onTap: (isLiked) async {
                                          bloc.toggleFavorite(id);
                                          bookmarksBloc.toggleFavorite(
                                            id,
                                            onFailure: () => bloc.toggleFavorite(id),
                                          );
                                          return !isLiked;
                                        },
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: context.colorTheme.primary,
                                          dotSecondaryColor: context.colorTheme.secondary,
                                        ),
                                        isLiked: state.isBookmarked,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        likeBuilder: (isLiked) => Icon(
                                          isLiked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                          size: 42,
                                          color: context.colorTheme.primary,
                                        ),
                                      ),
                                      LikeButton(
                                        padding: EdgeInsets.zero,
                                        size: 42,
                                        onTap: (isLiked) async {
                                          return !isLiked;
                                        },
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: context.colorTheme.primary,
                                          dotSecondaryColor: Colors.redAccent,
                                        ),
                                        likeBuilder: (isLiked) => Icon(
                                          isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                          size: 42,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.ios_share,
                                          size: 42,
                                          color: context.colorTheme.primary,
                                        ),
                                        onPressed: () {
                                          locator.get<ShareService>().shareArt(
                                                context,
                                                title: data.title,
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

  Builder _buildSourceInfo(ArtModel? data, TextStyle infoStyle) {
    return Builder(
      key: GlobalKey(debugLabel: 'SOURCE INFO'),
      builder: (context) {
        final color = context.colorTheme.cardBackground;
        final fontColor = context.colorTheme.onCardBackground;
        return SliverCardContainer(
          borderRadius: kMediumBorderRadius,
          color: color,
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kSmallBorderRadius,
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
        final color = context.colorTheme.cardBackground;
        final tags = data?.tags ?? [];
        return SliverToBoxAdapter(
          child: CardContainer(
            borderRadius: kMediumBorderRadius,
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
        final color = context.colorTheme.cardBackground;
        final fontColor = context.colorTheme.onCardBackground;
        return SliverCardContainer(
          borderRadius: kMediumBorderRadius,
          color: color,
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kSmallBorderRadius,
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
                                style: context.textTheme.titleTiny.withColor(fontColor).style,
                              ),
                              TextSpan(
                                text: data?.artists.firstOrNull?.name ?? 'N/A',
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
                                style: context.textTheme.titleTiny.withColor(fontColor).style,
                              ),
                              TextSpan(
                                text: data?.artists.firstOrNull?.biography ?? 'N/A',
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
                                style: context.textTheme.titleTiny.withColor(fontColor).style,
                              ),
                              TextSpan(
                                text: data?.artists.firstOrNull?.website ?? 'N/A',
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
          final color = context.colorTheme.cardBackground;
          final fontColor = context.colorTheme.onCardBackground;
          if (data == null) {
            return kSliverFillAnimatedLoading;
          }
          return SliverCardContainer(
            borderRadius: kMediumBorderRadius,
            color: color,
            padding: kTinyPadding,
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: kSmallBorderRadius,
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
                        style: context.textTheme.bodyMedium.copyWith(color: fontColor).style,
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
                            style: context.textTheme.bodyMedium.copyWith(color: fontColor).style,
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
            return kSliverFillAnimatedLoading;
          }
          return SliverCardContainer(
            borderRadius: kMediumBorderRadius,
            color: Colors.transparent,
            padding: EdgeInsets.zero,
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: kSmallBorderRadius,
                ),
                padding: kTinyPadding,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleSmall
                            .withColor(
                              context.colorTheme.onBackground,
                            )
                            .style,
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
