import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_bloc.dart';
import 'package:art_for_all/modules/art_detail_screen/widgets/tag_chip.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ArtistDetailScreen extends StatefulWidget {
  static String name = 'artist-detail-screen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<ArtistAbstractModel>? extra;

  const ArtistDetailScreen({super.key, required this.id, this.extra});

  @override
  State<ArtistDetailScreen> createState() => _ArtistDetailScreenState();
}

class _ArtistDetailScreenState extends State<ArtistDetailScreen> {
  final _bloc = locator.get<ArtistDetailBloc>();
  final navigator = locator.get<NavigationService>();

  @override
  void initState() {
    _bloc.init(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<ArtistDetailBloc, ArtistDetailBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.isLoading == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.artist == null) {
            return const SizedBox();
          }

          final artist = state.artist!;

          return CustomScrollView(
            slivers: [
              ArtistDetailHeader(artist: artist),
              SliverPadding(
                padding: kMediumPadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name,
                        style:
                            context.typographyTheme.titleMedium.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        artist.description,
                        style: context.typographyTheme.bodyLarge.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          direction: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          spacing: 4,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: artist.tags.map((t) {
                            return TagChipContainer(
                              onTap: () {},
                              tag: t,
                            );
                          }).toList(),
                        ),
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
                      ...artist.links.map(
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ArtistDetailHeader extends StatefulWidget {
  const ArtistDetailHeader({super.key, required this.artist});

  final ArtistModel artist;

  @override
  State<ArtistDetailHeader> createState() => _ArtistDetailHeaderState();
}

class _ArtistDetailHeaderState extends State<ArtistDetailHeader> {
  double heroOpacity = 1;
  bool _favorite = false;
  bool _bookmark = false;

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.vHeight / 2.4;
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
          final media = widget.artist.media.map((m) {
            return ZoomImage(constraints: constraints, media: m);
          }).toList();
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
                  padding: EdgeInsets.only(
                    top: (context.vTopSafeHeight - kToolbarHeight).clamp(0, kToolbarHeight),
                    right: (kToolbarHeight / 2) * (actions.length - 2),
                    left: kToolbarHeight + kMediumPadding.right,
                  ),
                  child: Text(
                    widget.artist.name,
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
                      imageUrl: widget.artist.media.first.url,
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
                        enableInfiniteScroll: media.length > 2,
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

class ZoomImage extends StatelessWidget {
  final MediaModel media;
  final BoxConstraints constraints;
  const ZoomImage({
    super.key,
    required this.media,
    required this.constraints,
  });

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 48,
        width: 48,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetZoom(
      heroAnimationTag: media.id,
      fullScreenDoubleTapZoomScale: 2,
      minScaleFullscreen: 0.1,
      minScaleEmbeddedView: .1,
      zoomWidget: LayoutBuilder(builder: (context, box) {
        return CachedNetworkImage(
          imageUrl: media.url,
          imageBuilder: (context, imageProvider) => Container(
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: box.maxHeight >= (context.vHeight / 2) ? BoxFit.contain : BoxFit.cover,
                opacity: 1,
              ),
              color: context.colorTheme.primaryContainer,
              borderRadius: kMediumBorderRadius,
            ),
          ),
          placeholder: (context, url) => _buildLoading(),
          // errorWidget: (context, url, error) => _buildCard(null, color, child),
        );
      }),
    );
  }
}
