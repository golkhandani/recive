import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/detail_art_screen/detail_art_bloc.dart';
import 'package:art_for_all/modules/detail_art_screen/widgets/tag_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtDetailScreen extends StatefulWidget {
  static String name = 'ArtDetailScreen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<ArtDetailSummaryData>? extra;

  const ArtDetailScreen({super.key, required this.id, this.extra});

  @override
  State<ArtDetailScreen> createState() => _ArtDetailScreenState();
}

class _ArtDetailScreenState extends State<ArtDetailScreen> {
  final carouselController = CarouselController(initialItem: 0);
  final bloc = locator.get<DetailArtBloc>();

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
    final cardMaxWidth = context.vWidth / 1.1;
    final cardMaxHeight = context.vHeight / 3;
    final Widget header = Container(
      color: context.colorTheme.primaryContainer,
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const BackButton(),
              Expanded(
                child: Center(
                  child: Text(
                    widget.extra?.summary?.title ?? "",
                    style: context.typographyTheme.titleSmall.textStyle.copyWith(
                      color: context.colorTheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
      ),
    );

    return BlocBuilder<DetailArtBloc, DetailArtBlocState>(
      bloc: bloc,
      builder: (context, state) {
        final data = state.art;
        final fontColor = context.colorTheme.onSurface;
        return ColoredBox(
          color: context.colorTheme.surface,
          child: CustomScrollView(slivers: [
            PinnedHeaderSliver(child: header),
            if (data != null) ...[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: cardMaxHeight,
                  width: context.vWidth,
                  child: CarouselView(
                      controller: carouselController,
                      itemSnapping: true,
                      padding: kSmallPadding,
                      elevation: 1,
                      itemExtent: cardMaxWidth,
                      shrinkExtent: cardMaxWidth,
                      shape: RoundedRectangleBorder(borderRadius: kSmallBorderRadius),
                      onTap: (index) {},
                      children: data.images.map((image) {
                        Widget buildLoading() {
                          return const Center(
                              child: SizedBox(
                                  height: 48, width: 48, child: CircularProgressIndicator()));
                        }

                        Widget buildCard(
                          ImageProvider<Object>? imageProvider,
                        ) {
                          return Container(
                            decoration: BoxDecoration(
                              image: imageProvider == null
                                  ? null
                                  : DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      opacity: 0.9,
                                    ),
                              borderRadius: kSmallBorderRadius,
                              color: Colors.black,
                            ),
                          );
                        }

                        return CachedNetworkImage(
                          imageUrl: image.imageUrl,
                          imageBuilder: (context, imageProvider) => buildCard(imageProvider),
                          placeholder: (context, url) => buildLoading(),
                          errorWidget: (context, url, error) => buildCard(null),
                        );
                      }).toList()),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Padding(
                  padding: kMediumPadding,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          data.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.typographyTheme.titleSmall.textStyle.withColor(
                            fontColor,
                          ),
                        ),
                      ),
                      Gap(kMediumPadding.bottom),
                      Center(
                        child: Text(
                          data.description,
                          style: context.typographyTheme.bodyMedium.textStyle
                              .copyWith(color: fontColor, height: 1.8),
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
                      Gap(kMediumPadding.bottom),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            color: context.colorTheme.onSurface,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Location: ',
                                    style: context.typographyTheme.titleTiny.textStyle
                                        .withColor(fontColor),
                                  ),
                                  TextSpan(
                                    text: data.location.venue.address.localizedAddressDisplay,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographyTheme.bodyMedium.textStyle
                                  .withColor(fontColor),
                            ),
                          ),
                        ],
                      ),
                      Gap(kMediumPadding.bottom),
                      Row(
                        children: [
                          Icon(
                            Icons.business_outlined,
                            color: fontColor,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Organizer: ',
                                    style: context.typographyTheme.titleTiny.textStyle
                                        .withColor(fontColor),
                                  ),
                                  TextSpan(
                                    text: data.artists.firstOrNull?.name ?? 'N/A',
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographyTheme.bodyMedium.textStyle
                                  .withColor(fontColor),
                            ),
                          )
                        ],
                      ),
                      Gap(kMediumPadding.bottom),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.article_rounded,
                            color: fontColor,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Bio: ',
                                    style: context.typographyTheme.titleTiny.textStyle
                                        .withColor(fontColor),
                                  ),
                                  TextSpan(
                                    text: data.artists.firstOrNull?.biography ?? 'N/A',
                                  ),
                                ],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographyTheme.bodyMedium.textStyle
                                  .withColor(fontColor),
                            ),
                          )
                        ],
                      ),
                      Gap(kMediumPadding.bottom),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.web,
                            color: fontColor,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Website: ',
                                    style: context.typographyTheme.titleTiny.textStyle
                                        .withColor(fontColor),
                                  ),
                                  TextSpan(
                                    text: data.artists.firstOrNull?.website ?? 'N/A',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                          data.artists.firstOrNull!.website,
                                        ));
                                      },
                                    style:
                                        context.typographyTheme.bodyMedium.textStyle.copyWith(
                                      color: fontColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              style: context.typographyTheme.bodyMedium.textStyle,
                            ),
                          )
                        ],
                      ),
                      Gap(kMediumPadding.bottom),
                      Row(
                        children: [
                          Icon(
                            Icons.source,
                            color: fontColor,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Source : '),
                                  TextSpan(
                                    text: data.source.name,
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographyTheme.bodyMedium.textStyle
                                  .withColor(fontColor),
                            ),
                          )
                        ],
                      ),
                      Gap(kMediumPadding.bottom),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.web_asset,
                            color: fontColor,
                            size: 36,
                          ),
                          Gap(kMediumPadding.right),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Source URL : '),
                                  TextSpan(
                                    text: data.source.copyRight,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                          data.source.copyRight,
                                        ));
                                      },
                                    style:
                                        context.typographyTheme.bodyMedium.textStyle.copyWith(
                                      color: fontColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              style: context.typographyTheme.bodyMedium.textStyle
                                  .withColor(fontColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]
          ]),
        );
      },
    );
  }
}
