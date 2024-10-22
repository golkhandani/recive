import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/community_card_container.dart';
import 'package:art_for_all/modules/art_detail_screen/widgets/tag_chip.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatefulWidget {
  static String name = 'event-detail-screen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<CategoryCardContainerData>? extra;

  const EventDetailScreen({super.key, required this.id, this.extra});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _bloc = locator.get<EventDetailBloc>();

  @override
  void initState() {
    _bloc.init(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<EventDetailBloc, EventDetailBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.isLoading == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.event == null) {
            return const SizedBox();
          }

          final event = state.event!;

          return CustomScrollView(
            slivers: [
              EventDetailHeader(event: event),
              SliverPadding(
                padding: kMediumPadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
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
                        event.eventType,
                        style: context.typographyTheme.titleTiny.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        event.description,
                        style: context.typographyTheme.bodyLarge.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      ArtCardContainer.medium(
                        data: ArtCardContainerData.fromAbstractArt(event.art),
                        constraints: BoxConstraints(
                          maxHeight: context.vWidth,
                          maxWidth: context.vWidth,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      ...event.highlights.map((h) {
                        return Text(
                          "* $h",
                          style:
                              context.typographyTheme.bodyLarge.onPrimaryContainer.textStyle,
                        );
                      }),
                      SizedBox(height: kMediumPadding.bottom),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          direction: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          spacing: 4,
                          runSpacing: 12,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: event.tags.map((t) {
                            return TagChipContainer(
                              onTap: () {},
                              tag: t,
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      ...event.link.map(
                        (l) {
                          return Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "${l.title}: "),
                                TextSpan(
                                  text: l.url,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(l.url));
                                    },
                                  style: context.typographyTheme.bodyLarge.primary.textStyle,
                                ),
                              ],
                            ),
                            style: context
                                .typographyTheme.bodyLarge.onPrimaryContainer.textStyle,
                          );
                        },
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      CommunityCardContainer.big(
                        data: CommunityCardContainerData.fromAbstractCommunity(
                          event.community,
                        ),
                        constraints: BoxConstraints(
                          maxHeight: context.vHeight / 5,
                          maxWidth: context.vWidth,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: kLargePadding.bottom),
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

class EventDetailHeader extends StatefulWidget {
  const EventDetailHeader({super.key, required this.event});

  final EventModel event;

  @override
  State<EventDetailHeader> createState() => _EventDetailHeaderState();
}

class _EventDetailHeaderState extends State<EventDetailHeader> {
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
          final media = widget.event.media
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
          return FlexibleSpaceBar(
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
                  widget.event.title,
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
                    imageUrl: widget.event.media.first.url,
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
                    placeholder: (context, url) => _buildLoading(),
                    // errorWidget: (context, url, error) => _buildCard(null, color, child),
                  ),
                ),
                Positioned.fill(
                  top: kToolbarHeight + context.vTopSafeHeight,
                  bottom: kMediumPadding.bottom,
                  child: CarouselSlider.builder(
                    // carouselController: carouselController,
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
          );
        },
      ),
    );
  }
}
