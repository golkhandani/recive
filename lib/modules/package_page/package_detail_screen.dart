import 'dart:math';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:timelines/timelines.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/colored_network_image.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/package_page/cubits/packages_cubit.dart';
import 'package:recive/modules/package_page/models/art_route_model.dart';
import 'package:recive/modules/package_page/widgets/art_route_art_card_container.dart';
import 'package:recive/modules/package_page/widgets/art_route_art_card_container_data.dart';
import 'package:recive/modules/package_page/widgets/art_route_detail_map_section.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/duration_extensions.dart';
import 'package:recive/shared/extensions/string_extensions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/router/extra_data.dart';

class PackageDetailScreen extends HookWidget {
  static const name = 'package_detail';
  static const pathParamId = 'packageId';
  const PackageDetailScreen({
    super.key,
    required this.id,
    this.extra,
  });

  final String id;
  final ExtraData<PackageSummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<PackagesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadPackage(id);
      return () => bloc.emptyPackage();
    }, []);

    final data = state.package;
    final summary = extra?.summary;
    final heroTag = extra?.heroTag ?? "RWE@";

    return ColoredBox(
      color: context.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            title: (summary?.title ?? data?.title ?? '').dynamicSub(20),
          ),
          SliverPadding(
            padding: kTinyPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: Builder(builder: (context) {
              if (summary == null && data == null) {
                return kSliverFillAnimatedLoading;
              }

              return MultiSliver(
                children: [
                  _buildImageCarousel(summary, data, heroTag),
                  const SliverGap(height: 12),
                  Builder(builder: (context) {
                    if (state.packageLoadingState == LoadingState.loading ||
                        data == null) {
                      return kSkeletonSectionLoadingBox;
                    }

                    final infoStyle = context.textTheme.body1
                        .withColor(
                          context.colorScheme.onPrimaryContainer,
                        )
                        .style;
                    return MultiSliver(
                      children: [
                        Builder(builder: (context) {
                          final color = context.colorScheme.background;
                          final fontColor = context.colorScheme.onBackground;
                          return SliverCardContainer(
                            borderRadius: kMediumBorderRadius,
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: kSmallBorderRadius,
                                  color: color,
                                ),
                                child: Text(
                                  data.title,
                                  style: context.textTheme.titleMedium
                                      .withColor(fontColor)
                                      .style,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SliverGap(height: 12),
                        Builder(builder: (context) {
                          final color = context.colorScheme.secondary;
                          final fontColor = context.colorScheme.onSecondary;
                          return SliverCardContainer(
                            borderRadius: kMediumBorderRadius,
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: kSmallBorderRadius,
                                  color: color,
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        data.description,
                                        style: infoStyle.withColor(fontColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SliverGap(height: 12),
                        _buildTagInfo(data.tags.take(10).toList()),
                        const SliverGap(height: 12),
                        Builder(builder: (context) {
                          final color = context.colorScheme.secondary;
                          final fontColor = context.colorScheme.onSecondary;
                          return SliverCardContainer(
                            borderRadius: kMediumBorderRadius,
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: kSmallBorderRadius,
                                  color: color,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Distance: ${data.distance.toInt() / 1000} km!',
                                      style: infoStyle.withColor(fontColor),
                                    ),
                                    Text(
                                      'Duration: ${data.duration.toHoursMinutes()}!',
                                      style: infoStyle.withColor(fontColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SliverGap(height: 12),
                        // _buildInstruction(infoStyle, data),
                        const SliverGap(height: 12),
                        ArtRouteDetailMapSection(
                          arts: data.arts,
                          polyline: data.polyline ?? [],
                        ),
                        const SliverGap(height: 12),
                        CardContainer(
                          color: context.colorScheme.secondary,
                          borderRadius: kMediumBorderRadius,
                          padding: kTinyPadding.copyWith(left: 12, top: 24),
                          child: LayoutBuilder(builder: (context, box) {
                            return FixedTimeline.tileBuilder(
                              theme: TimelineThemeData(
                                connectorTheme: ConnectorThemeData(
                                  color: context.colorScheme.primary,
                                  thickness: 5,
                                ),
                                indicatorTheme: IndicatorThemeData(
                                  color: context.colorScheme.primary,
                                  size: 25,
                                ),
                                nodeItemOverlap: true,
                              ),
                              builder: TimelineTileBuilder.connectedFromStyle(
                                contentsAlign: ContentsAlign.basic,
                                nodePositionBuilder: (context, index) => 0,
                                connectionDirection: ConnectionDirection.before,
                                indicatorPositionBuilder: (context, index) =>
                                    index == 0 ? 0.3 : 0,
                                firstConnectorStyle: ConnectorStyle.transparent,
                                connectorStyleBuilder: (context, index) =>
                                    ConnectorStyle.solidLine,
                                indicatorStyleBuilder: (context, index) =>
                                    index == 1
                                        ? IndicatorStyle.transparent
                                        : IndicatorStyle.dot,
                                itemCount: data.arts.length + 2,
                                contentsBuilder: (context, contentIndex) =>
                                    Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Builder(builder: (context) {
                                    final index = contentIndex - 1;
                                    // First
                                    if (index == -1) {
                                      return _buildFirstContent(context, box);
                                    }

                                    // Last
                                    if (index == data.arts.length) {
                                      return const SizedBox();
                                    }

                                    return _buildContent(
                                      context,
                                      data,
                                      index,
                                      box,
                                    );
                                  }),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SliverGap(height: 12),
                      ],
                    );
                  })
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  CardContainer _buildImageCarousel(
      PackageSummaryData? summary, ArtRouteModel? data, String heroTag) {
    return CardContainer(
      borderRadius: kMediumBorderRadius,
      padding: kTinyPadding,
      child: LayoutBuilder(builder: (context, box) {
        // Warning: To stop rebuild issue
        // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
        final list = [
          summary?.imageUrl ?? data!.imageUrl,
          ...(data?.arts.map((e) => e.imageUrl).toList() ??
              // Warning: TO FIX THE ISSUE WITH SAME HERO TAG
              [
                summary?.imageUrl ?? data!.imageUrl,
                summary?.imageUrl ?? data!.imageUrl,
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

        final options = CarouselOptions(
          autoPlay: false,
          disableCenter: true,
          viewportFraction: 0.8,
          height: 360,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          enlargeFactor: 0.24,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          padEnds: true,
        );
        return CarouselSlider(
          items: list,
          options: options,
        );
      }),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ArtRouteModel data,
    int index,
    BoxConstraints box,
  ) {
    final safeInstructions = data.roadInstructions ?? [];
    final List<String> instructions = index > 0
        ? safeInstructions[max(index - 1, safeInstructions.length - 1)]
        : [];
    return Column(
      children: [
        const SizedBox(height: 12),
        ArtRouteCardContainer(
          parentRoute: PackageDetailScreen.name,
          parentPathParams: {
            PackageDetailScreen.pathParamId: data.id,
          },
          data: ArtRouteArtCardContainerData.fromArtAbstract(
            data.arts[index],
            instructions,
          ),
          constraints: BoxConstraints.expand(
            height: 360 + instructions.length * 48,
            width: box.maxWidth - 48,
          ),
        ),
        _buildLastContent(context, box),
      ],
    );
  }

  Container _buildLastContent(
    BuildContext context,
    BoxConstraints box,
  ) {
    return Container(
      height: 5,
      color: context.colorScheme.primary,
      width: box.maxWidth - 48,
      margin: EdgeInsets.only(top: 40),
    );
  }

  Container _buildFirstContent(
    BuildContext context,
    BoxConstraints box,
  ) {
    return Container(
      height: 42,
      width: box.maxWidth - 48,
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        'Start your journey Here!',
        style: context.textTheme.titleSmall.onTertiaryContainer.style,
      ),
    );
  }

  Builder _buildTagInfo(List<String>? data) {
    return Builder(
      key: GlobalKey(debugLabel: 'TAG INFO'),
      builder: (context) {
        final tags = data ?? [];
        final color = context.colorScheme.secondary;

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
                    onTap: () {},
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
}
