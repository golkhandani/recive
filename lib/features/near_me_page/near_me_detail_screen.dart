import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/components/colored_network_image.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/near_me_page/cubits/near_by_event_detail_cubit.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyDetailScreen extends HookWidget {
  static const name = 'neerby_event_datail';
  static const pathParamId = 'id';
  const NearbyDetailScreen({
    super.key,
    required this.id,
    required this.extra,
  });

  final String id;
  final ExtraData<NearbyDetailSummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<NearbyEventDetailCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadNearbyEvent(id);
      return () => bloc.emptyNearbyEvent();
    }, []);

    final heroTag = extra?.heroTag ?? DateTime.now().toString();
    final summary = extra?.summary;
    final data = state.nearbyEvent;
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
                  final isOnline = (data?.isOnlineEvent ?? false);

                  return MultiSliver(
                    children: [
                      _buildImageCarousel(summary, data, heroTag),
                      // _buildImageContainer(heroTag, summary, data),
                      const SliverGap(height: 12),
                      Builder(
                        builder: (context) {
                          if (data == null && loading == LoadingState.done) {
                            return kSliverFillLoading;
                          }
                          return MultiSliver(
                            children: [
                              _buildTitleInfo(summary, data),
                              const SliverGap(height: 12),
                              _buildBasicInfo(data, infoStyle),
                              const SliverGap(height: 12),
                              _buildPriceInfo(data, infoStyle),
                              const SliverGap(height: 12),
                              _buildOrganizerInfo(data, infoStyle),
                              const SliverGap(height: 12),
                              _buildTagInfo(data),
                              const SliverGap(height: 12),
                              _buildTypeInfo(isOnline, infoStyle),
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

  CardContainer _buildImageCarousel(
      NearbyDetailSummaryData? summary, EventComplete? data, String heroTag) {
    return CardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: kTinyPadding,
      child: LayoutBuilder(builder: (context, box) {
        if ((summary?.imageUrl ?? data!.imageUrl) == null) {
          return const SizedBox();
        }
        // Warning: To prevent rebuild issue
        // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
        final list = [
          summary?.imageUrl ?? data!.imageUrl,
          ...(data?.imageUrls?.toList() ??
              // TO FIX THE ISSUE WITH SAME HERO TAG
              [
                summary?.imageUrl ?? data!.imageUrl!,
                summary?.imageUrl ?? data!.imageUrl!,
              ])
        ]
            .mapIndexed((index, data) => ColoredNetworkImage(
                  imageUrl: data!,
                  constraints: const BoxConstraints.expand(height: 240),
                  color: Colors.blueGrey,
                ))
            .toList();

        final options = CarouselOptions(
          autoPlay: false,
          disableCenter: true,
          viewportFraction: .8,
          height: 360,
          indicatorMargin: 12.0,
          floatingIndicator: true,
          slideIndicator: CircularWaveSlideIndicator(
            currentIndicatorColor: context.colorScheme.secondary,
            indicatorBackgroundColor: context.colorScheme.primary,
          ),
          allowImplicitScrolling: true,
          showIndicator: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          padEnds: true,
        );
        return FlutterCarousel.builder(
          options: options,
          itemCount: list.length,
          itemBuilder: (context, index, realIndex) {
            if (index == 0) {
              return Hero(
                tag: heroTag,
                child: list[index],
              );
            }
            return list[index];
          },
        );
      }),
    );
  }

  Builder _buildSourceInfo(EventComplete? data, TextStyle infoStyle) {
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
                      Iconify(
                        Bx.info_circle,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Source : '),
                              if (data?.source?.name != null)
                                TextSpan(
                                  text: data?.source?.name,
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
                      Iconify(
                        Mdi.web,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Source URL : '),
                              if (data?.source?.url != null)
                                TextSpan(
                                  text: data?.source?.url,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(
                                        data!.source!.url!,
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

  Builder _buildTagInfo(EventComplete? data) {
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
                  (index) => Material(
                    borderRadius: BorderRadius.circular(8),
                    color: context.theme.colorScheme.tertiary,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      splashColor: context.theme.colorScheme.tertiaryContainer,
                      onTap: () {
                        if (kDebugMode) {
                          print(
                              '_________________| on tap tags ${tags[index]}');
                        }
                      },
                      child: Container(
                        padding: kMediumPadding,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tags[index],
                          style: context.textTheme.bodyMedium?.withColor(
                            context.theme.colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Builder _buildOrganizerInfo(EventComplete? data, TextStyle infoStyle) {
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
                      Iconify(
                        Mdi.briefcase_outline,
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
                              if (data?.organizer?.title != null)
                                TextSpan(
                                  text: data?.organizer?.title,
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
                      Iconify(
                        Mdi.person_group_outline,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Followers : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.organizer?.numFollowers != null)
                                TextSpan(
                                  text:
                                      data?.organizer?.numFollowers.toString(),
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
                      Iconify(
                        Mdi.web,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Web : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.organizer?.description != null)
                                TextSpan(
                                  text: data?.organizer?.websiteUrl,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(
                                        data!.organizer!.websiteUrl!,
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

  Builder _buildPriceInfo(EventComplete? data, TextStyle infoStyle) {
    return Builder(
      key: GlobalKey(debugLabel: 'PRICE INFO'),
      builder: (context) {
        final color = (data?.isFree ?? false)
            ? context.colorScheme.tertiaryContainer
            : context.colorScheme.errorContainer;
        final fontColor = (data?.isFree ?? false)
            ? context.colorScheme.onTertiaryContainer
            : context.colorScheme.onErrorContainer;
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
                      Iconify(
                        Bx.bx_money_withdraw,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.isFree ?? false) ...[
                                TextSpan(
                                  text: 'It\'s Free',
                                  style: context.textTheme.bodyLarge
                                      ?.withColor(fontColor),
                                ),
                              ] else ...[
                                if (data?.minPrice != null)
                                  TextSpan(
                                    text:
                                        'From \$${(data!.minPrice ?? 0).toStringAsFixed(2)} ',
                                    style: context.textTheme.bodyLarge
                                        ?.withColor(fontColor),
                                  ),
                                if (data?.maxPrice != null &&
                                    data?.maxPrice != data?.minPrice)
                                  TextSpan(
                                    text:
                                        'To \$${(data!.maxPrice ?? 0).toStringAsFixed(2)} ',
                                    style: context.textTheme.bodyLarge
                                        ?.withColor(fontColor),
                                  ),
                              ]
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Iconify(
                        Mdi.ticket_percent_outline,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Ticket : ',
                                style: context.textTheme.titleMedium
                                    ?.withColor(fontColor),
                              ),
                              if (data?.isSoldOut ?? false)
                                TextSpan(
                                  text: 'Tickets are sold out',
                                  style: context.textTheme.bodyLarge
                                      ?.withColor(fontColor),
                                ),
                              if (data?.hasAvailableTickets ?? false)
                                TextSpan(
                                  text: 'Tickets are still available',
                                  style: context.textTheme.bodyLarge
                                      ?.withColor(fontColor),
                                ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Iconify(
                        Bx.calendar_event,
                        color: fontColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Date : ',
                              style: context.textTheme.titleMedium
                                  ?.withColor(fontColor),
                            ),
                            if (data?.startDate != null)
                              TextSpan(
                                text:
                                    DateFormat.yMMMd().format(data!.startDate!),
                                style: context.textTheme.bodyLarge
                                    ?.withColor(fontColor),
                              ),
                            if (data?.endDate != null)
                              TextSpan(
                                text:
                                    '- ${DateFormat.yMMMd().format(data!.endDate!)}',
                                style: context.textTheme.bodyLarge
                                    ?.withColor(fontColor),
                              )
                          ]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleMedium
                              ?.withColor(fontColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Builder _buildBasicInfo(EventComplete? data, TextStyle infoStyle) {
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
                        data.description ?? '',
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: fontColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Iconify(
                          Mdi.resource_description_framework,
                          color: fontColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'About : \n',
                                  style: context.textTheme.titleMedium
                                      ?.withColor(fontColor),
                                ),
                                if (data.organizer?.description != null)
                                  TextSpan(
                                    text: data.organizer?.description,
                                    style: infoStyle.copyWith(
                                      color: fontColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                            style: infoStyle.withColor(fontColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Iconify(
                          Bx.bxs_map,
                          color: fontColor,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            data.venue?.address?.localizedAddressDisplay ?? '',
                            overflow: TextOverflow.fade,
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: fontColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (data.organizer?.title != null)
                      Row(
                        children: [
                          Iconify(
                            Bx.briefcase,
                            color: fontColor,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              data.organizer?.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyLarge!.copyWith(
                                color: fontColor,
                              ),
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
        });
  }

  Builder _buildTitleInfo(
    NearbyDetailSummaryData? summary,
    EventComplete? data,
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

  Builder _buildTypeInfo(bool isOnline, TextStyle infoStyle) {
    return Builder(
      key: GlobalKey(debugLabel: 'TYPE INFO'),
      builder: (context) {
        return SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          color: context.colorScheme.background,
          padding: EdgeInsets.zero,
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: kTinyPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Iconify(
                        Mdi.warning,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'This is an ${isOnline ? 'online' : 'in-person'} event !',
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: infoStyle.copyWith(
                            color: Colors.redAccent,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
