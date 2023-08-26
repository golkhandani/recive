import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/near_me_page/cubits/near_by_event_detail_cubit.dart';
import 'package:recive/features/near_me_page/widgets/event_card_container.dart';
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
  final ExtraData<EventCardContainerData>? extra;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<NearbyEventDetailCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadNearbyEvent(id);
      return () => bloc.emptyNearbyEvent();
    }, []);

    final heroTag = extra?.heroTag ?? DateTime.now();
    final summary = extra?.summary;
    final data = state.nearbyEvent;
    final loading = state.loadingState;

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          if (summary != null || data != null) ...[
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: summary?.title ?? data?.title ?? '',
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16)
                  .copyWith(bottom: context.footerHeight + 32),
              sliver: Builder(
                builder: (context) {
                  const loadingWidget = SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  if (summary == null &&
                      data == null &&
                      loading != LoadingState.done) {
                    return loadingWidget;
                  }

                  final infoStyle = context.textTheme.bodyLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer);

                  final isOnline = (data?.isOnlineEvent ?? false);
                  return MultiSliver(
                    children: [
                      SliverCardContainer(
                        borderRadius: BorderRadius.circular(16),
                        padding: const EdgeInsets.all(12),
                        sliver: SliverToBoxAdapter(
                          child: Hero(
                            tag: heroTag,
                            child: CachedNetworkImage(
                              imageUrl: summary?.imageUrl ?? data!.imageUrl!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  height: 240,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      opacity: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueGrey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SliverGap(height: 12),
                      Builder(
                        builder: (context) {
                          if (data == null && loading == LoadingState.done) {
                            return loadingWidget;
                          }
                          return MultiSliver(
                            children: [
                              Builder(
                                key: GlobalKey(debugLabel: 'PRICE INFO'),
                                builder: (context) {
                                  return SliverCardContainer(
                                    borderRadius: BorderRadius.circular(16),
                                    padding: const EdgeInsets.all(12),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: context
                                              .theme.colorScheme.background,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Iconify(
                                                  Mdi.warning,
                                                  color: Colors.redAccent,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: infoStyle.copyWith(
                                                      color: Colors.redAccent,
                                                      fontSize: 20,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                              ),
                              const SliverGap(height: 12),
                              Builder(
                                  key: GlobalKey(debugLabel: 'TITLE INFO'),
                                  builder: (context) {
                                    final title = summary?.title ?? data?.title;
                                    if (title == null) {
                                      return loadingWidget;
                                    }
                                    return SliverCardContainer(
                                      borderRadius: BorderRadius.circular(16),
                                      padding: const EdgeInsets.all(12),
                                      sliver: SliverToBoxAdapter(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: context
                                                .theme.colorScheme.secondary,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  title,
                                                  textAlign: TextAlign.center,
                                                  style: context
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: context
                                                        .theme
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              const SliverGap(height: 12),
                              Builder(
                                  key: GlobalKey(debugLabel: 'BASIC INFO'),
                                  builder: (context) {
                                    if (data == null) {
                                      return loadingWidget;
                                    }
                                    return SliverCardContainer(
                                      borderRadius: BorderRadius.circular(16),
                                      padding: const EdgeInsets.all(12),
                                      sliver: SliverToBoxAdapter(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: context.theme.colorScheme
                                                .primaryContainer,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  data.description ?? '',
                                                  style: context
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    color: context
                                                        .theme
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                children: [
                                                  Iconify(
                                                    Bx.bxs_map,
                                                    color: context.theme
                                                        .colorScheme.background,
                                                    size: 24,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      data.venue?.address
                                                              ?.localizedAddressDisplay ??
                                                          '',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: context
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                        color: context
                                                            .theme
                                                            .colorScheme
                                                            .onPrimaryContainer,
                                                      ),
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
                                                      color: context
                                                          .theme
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Expanded(
                                                      child: Text(
                                                        data.organizer?.title ??
                                                            '',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: context.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                          color: context
                                                              .theme
                                                              .colorScheme
                                                              .onPrimaryContainer,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              const SliverGap(height: 12),
                              Builder(
                                key: GlobalKey(debugLabel: 'PRICE INFO'),
                                builder: (context) {
                                  return SliverCardContainer(
                                    borderRadius: BorderRadius.circular(16),
                                    padding: const EdgeInsets.all(12),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: (data?.isFree ?? false)
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Iconify(
                                                  Bx.bx_money_withdraw,
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'Price : '),
                                                        if (data?.isFree ??
                                                            false)
                                                          TextSpan(
                                                              text:
                                                                  'It\' Free'),
                                                        if (data?.minPrice !=
                                                            null)
                                                          TextSpan(
                                                            text:
                                                                'From \$${(data!.minPrice ?? 0).toStringAsFixed(2)} ',
                                                          ),
                                                        if (data?.maxPrice !=
                                                                null &&
                                                            data?.maxPrice !=
                                                                data?.minPrice)
                                                          TextSpan(
                                                            text:
                                                                'To \$${(data!.maxPrice ?? 0).toStringAsFixed(2)} ',
                                                          ),
                                                      ],
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'Ticket : '),
                                                        if (data?.isSoldOut ??
                                                            false)
                                                          TextSpan(
                                                            text:
                                                                'Tickets are sold out',
                                                          ),
                                                        if (data?.hasAvailableTickets ??
                                                            false)
                                                          TextSpan(
                                                            text:
                                                                'Tickets are still available',
                                                          ),
                                                      ],
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  color: context.theme
                                                      .colorScheme.background,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(children: [
                                                      if (data?.startDate !=
                                                          null)
                                                        TextSpan(
                                                          text:
                                                              '${DateFormat.yMMMd().format(data!.startDate!)}',
                                                        ),
                                                      if (data?.endDate != null)
                                                        TextSpan(
                                                          text:
                                                              '- ${DateFormat.yMMMd().format(data!.endDate!)}',
                                                        )
                                                    ]),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .textTheme.labelLarge!
                                                        .copyWith(
                                                      color: context
                                                          .theme
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                                    ),
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
                              ),
                              const SliverGap(height: 12),
                              Builder(
                                key: GlobalKey(debugLabel: 'ORGANIZER INFO'),
                                builder: (context) {
                                  return SliverCardContainer(
                                    borderRadius: BorderRadius.circular(16),
                                    padding: const EdgeInsets.all(12),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              Color.fromARGB(255, 53, 65, 146),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Iconify(
                                                  Mdi.briefcase_outline,
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'Organizer : '),
                                                        if (data?.organizer
                                                                ?.title !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.organizer
                                                                ?.title,
                                                          ),
                                                      ],
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: infoStyle,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                Iconify(
                                                  Mdi.person_group_outline,
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'Followers : '),
                                                        if (data?.organizer
                                                                ?.numFollowers !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.organizer
                                                                ?.numFollowers
                                                                .toString(),
                                                          ),
                                                      ],
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: infoStyle,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Iconify(
                                                  Mdi.resource_description_framework,
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'About : \n'),
                                                        if (data?.organizer
                                                                ?.description !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.organizer
                                                                ?.description,
                                                            style: infoStyle
                                                                .copyWith(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
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
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Iconify(
                                                  Mdi.web,
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'Web : '),
                                                        if (data?.organizer
                                                                ?.description !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.organizer
                                                                ?.websiteUrl,
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    launchUrl(Uri
                                                                        .parse(
                                                                      data!
                                                                          .organizer!
                                                                          .websiteUrl!,
                                                                    ));
                                                                  },
                                                            style: infoStyle
                                                                .copyWith(
                                                              color: context
                                                                  .theme
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
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
                              ),
                              const SliverGap(height: 12),
                              Builder(
                                key: GlobalKey(debugLabel: 'TAG INFO'),
                                builder: (context) {
                                  final tags = data?.tags ?? [];
                                  return SliverToBoxAdapter(
                                    child: CardContainer(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Center(
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceAround,
                                          direction: Axis.horizontal,
                                          clipBehavior: Clip.hardEdge,
                                          spacing: 12,
                                          runSpacing: 12,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: List.generate(
                                            tags.length,
                                            (index) => Material(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: context
                                                  .theme.colorScheme.tertiary,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                splashColor: context
                                                    .theme
                                                    .colorScheme
                                                    .tertiaryContainer,
                                                onTap: () {
                                                  if (kDebugMode) {
                                                    print(
                                                        '_________________| on tap tags ${tags[index]}');
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    tags[index],
                                                    style: context
                                                        .textTheme.titleMedium,
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
                              ),
                              const SliverGap(height: 12),
                              Builder(
                                key: GlobalKey(debugLabel: 'SOUCE INFO'),
                                builder: (context) {
                                  return SliverCardContainer(
                                    borderRadius: BorderRadius.circular(16),
                                    padding: const EdgeInsets.all(12),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.amber,
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Iconify(
                                                  Bx.info_circle,
                                                  color: context.theme
                                                      .colorScheme.onBackground,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'Source : '),
                                                        if (data?.source
                                                                ?.name !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.source?.name,
                                                          ),
                                                      ],
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: infoStyle.copyWith(
                                                      color: context
                                                          .theme
                                                          .colorScheme
                                                          .onBackground,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Iconify(
                                                  Mdi.web,
                                                  color: context.theme
                                                      .colorScheme.onBackground,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'Source URL : '),
                                                        if (data?.source?.url !=
                                                            null)
                                                          TextSpan(
                                                            text: data
                                                                ?.source?.url,
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    launchUrl(Uri
                                                                        .parse(
                                                                      data!
                                                                          .source!
                                                                          .url!,
                                                                    ));
                                                                  },
                                                            style: infoStyle
                                                                .copyWith(
                                                              color: context
                                                                  .theme
                                                                  .colorScheme
                                                                  .tertiaryContainer,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    style: infoStyle.withColor(
                                                      context.theme.colorScheme
                                                          .onBackground,
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
                              ),
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
}
