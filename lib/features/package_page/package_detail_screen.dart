import 'dart:math';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:timelines/timelines.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/colored_network_image.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/extensions/duration_extensions.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/package_page/cubits/packages_cubit.dart';
import 'package:recive/features/package_page/models/package.dart';
import 'package:recive/features/package_page/widgets/package_detail_map_section.dart';
import 'package:recive/features/package_page/widgets/package_event_card_container.dart';
import 'package:recive/features/package_page/widgets/package_event_card_container_data.dart';
import 'package:recive/features/search_page/widgets/tag_chip_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';

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
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            title: (summary?.title ?? data?.title ?? '').dynamicSub(24),
          ),
          SliverPadding(
            padding: kTinyPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: Builder(builder: (context) {
              if (summary == null && data == null) {
                return kSliverFillLoading;
              }

              return MultiSliver(
                children: [
                  _buildImageCarousel(summary, data, heroTag),
                  const SliverGap(height: 12),
                  Builder(builder: (context) {
                    if (state.packageLoadingState == LoadingState.loading ||
                        data == null) {
                      return kSliverFillLoading;
                    }

                    final infoStyle = context.textTheme.bodyLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    );
                    return MultiSliver(
                      children: [
                        Builder(builder: (context) {
                          final color = context.theme.colorScheme.background;
                          final fontColor =
                              context.theme.colorScheme.onBackground;
                          return SliverCardContainer(
                            borderRadius: BorderRadius.circular(16),
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: color,
                                ),
                                child: Text(
                                  data.title,
                                  style: context.titleLargeOnBackground
                                      .withColor(fontColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                        Builder(builder: (context) {
                          final color = context.theme.colorScheme.background;
                          final fontColor =
                              context.theme.colorScheme.onBackground;
                          return SliverCardContainer(
                            borderRadius: BorderRadius.circular(16),
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: color,
                                ),
                                child: Text(
                                  data.subtitle,
                                  style: context.textTheme.titleSmall
                                      ?.withColor(fontColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SliverGap(height: 12),
                        Builder(builder: (context) {
                          final color = context.theme.colorScheme.surface;
                          final fontColor = context.theme.colorScheme.onSurface;
                          return SliverCardContainer(
                            borderRadius: BorderRadius.circular(16),
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                          final color = context.theme.colorScheme.surface;
                          final fontColor = context.theme.colorScheme.onSurface;
                          return SliverCardContainer(
                            borderRadius: BorderRadius.circular(16),
                            padding: kTinyPadding,
                            color: color,
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                padding: kTinyPadding,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                        PackageDetailMapSection(
                          events: data.events,
                          polyline: data.polyline ?? [],
                        ),
                        const SliverGap(height: 12),
                        CardContainer(
                          color: context.theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          padding: kTinyPadding.copyWith(left: 12, top: 24),
                          child: LayoutBuilder(builder: (context, box) {
                            return FixedTimeline.tileBuilder(
                              theme: TimelineThemeData(
                                connectorTheme: ConnectorThemeData(
                                  color: context.colorScheme.secondary,
                                  thickness: 5,
                                ),
                                indicatorTheme: IndicatorThemeData(
                                  color: context.colorScheme.secondary,
                                  size: 25,
                                ),
                                nodeItemOverlap: true,
                              ),
                              builder: TimelineTileBuilder.connectedFromStyle(
                                contentsAlign: ContentsAlign.basic,
                                nodePositionBuilder: (context, index) => 0,
                                connectionDirection: ConnectionDirection.before,
                                indicatorPositionBuilder: (context, index) =>
                                    index == 0 ? 0.5 : 0,
                                firstConnectorStyle: ConnectorStyle.transparent,
                                connectorStyleBuilder: (context, index) =>
                                    ConnectorStyle.solidLine,
                                indicatorStyleBuilder: (context, index) =>
                                    index == 1
                                        ? IndicatorStyle.transparent
                                        : IndicatorStyle.dot,
                                itemCount: data.events.length + 2,
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
                                    if (index == data.events.length) {
                                      return const SizedBox();
                                    }

                                    return _buildEventContent(
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
      PackageSummaryData? summary, Package? data, String heroTag) {
    return CardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: kTinyPadding,
      child: LayoutBuilder(builder: (context, box) {
        // Warning: To prevent rebuild issue
        // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
        final list = [
          summary?.imageUrl ?? data!.imageUrl,
          ...(data?.events.map((e) => e.imageUrl).toList() ??
              // TO FIX THE ISSUE WITH SAME HERO TAG
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

  Widget _buildEventContent(
    BuildContext context,
    Package data,
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
        PackageEventCardContainer(
          parentRoute: PackageDetailScreen.name,
          parentPathParams: {
            PackageDetailScreen.pathParamId: data.id,
          },
          data: PackageEventCardContainerData.fromNearbyEvent(
            data.events[index],
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
      color: context.colorScheme.secondaryContainer,
      width: box.maxWidth - 48,
    );
  }

  SizedBox _buildFirstContent(
    BuildContext context,
    BoxConstraints box,
  ) {
    return SizedBox(
      height: 42,
      width: box.maxWidth - 48,
      child: Text(
        'Start your journey Here!',
        style: context.titleLargeOnBackground.withColor(
          context.colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }

  Builder _buildTagInfo(List<String>? data) {
    return Builder(
      key: GlobalKey(debugLabel: 'TAG INFO'),
      builder: (context) {
        final tags = data ?? [];
        final color = context.theme.colorScheme.surface;

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
