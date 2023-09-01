import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/quick_search_header_component.dart';
import 'package:recive/ioc/extra_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SearchScreen extends HookWidget {
  static const name = 'search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<SearchEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadSearchedKeywords();
      return;
    }, []);

    final resultState = useState(0);

    final textEditingController = useTextEditingController();
    useEffect(() {
      final query = textEditingController.text;
      if (query.length > 1) {
        bloc.searchedEvents(query, () => resultState.value = 2);
      }
      return;
    }, [textEditingController.text]);

    final showFilters = useState(false);

    final dateFilters = ['Any time', 'Today', 'This Week', 'This Month'];
    final dateFilterSwitchIndex = useState(0);

    final distancesFilters = ['Any where', '1 KM', '5 KM', '15 KM'];
    final distanceFiltersSwitchIndex = useState(0);

    final pricesFilters = ['Free', '\$', '\$\$', '\$\$\$\$'];
    final priceFilterStartValue = useState(0);
    final priceFilterEndValue = useState(pricesFilters.length - 1);
    final quickSearchBloc = useBloc<QuickSearchHeaderBloc>();

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        return CustomScrollView(
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Search',
            ),
            SliverPinnedHeader(
              child: ColoredBox(
                color: context.theme.colorScheme.primary,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PinnedSearchHeader(
                        padding:
                            const EdgeInsets.all(12).copyWith(top: 0, right: 0),
                        height: 56,
                        bloc: quickSearchBloc,
                        onSelect: (text) => resultState.value = 1,
                        onTextChanged: (text) =>
                            text.isNotEmpty ? null : resultState.value = 0,
                        textController: textEditingController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () => showFilters.value = !showFilters.value,
                      child: Container(
                        height: 56,
                        margin: const EdgeInsets.only(bottom: 12, right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Iconify(
                          Mdi.filter,
                          color: context.schema.primaryContainer,
                          size: 36,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ...[
              SliverPinnedHeader(
                child: LayoutBuilder(builder: (context, box) {
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    child: showFilters.value
                        ? Container(
                            color: context.theme.colorScheme.primary,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                                ToggleSwitch(
                                  minWidth:
                                      (box.maxWidth - 32) / dateFilters.length,
                                  initialLabelIndex:
                                      dateFilterSwitchIndex.value,
                                  activeBgColor: [
                                    context.theme.colorScheme.primaryContainer
                                  ],
                                  activeFgColor: context
                                      .theme.colorScheme.onPrimaryContainer,
                                  inactiveBgColor:
                                      context.theme.colorScheme.tertiary,
                                  inactiveFgColor:
                                      context.theme.colorScheme.onTertiary,
                                  totalSwitches: dateFilters.length,
                                  labels: dateFilters,
                                  animate: true,
                                  fontSize: 12,
                                  animationDuration: 200,
                                  onToggle: (index) {
                                    dateFilterSwitchIndex.value = index ?? 0;
                                  },
                                ),
                                const SizedBox(height: 12),
                                ToggleSwitch(
                                  minWidth: (box.maxWidth - 32) /
                                      distancesFilters.length,
                                  initialLabelIndex:
                                      distanceFiltersSwitchIndex.value,
                                  activeBgColor: [
                                    context.theme.colorScheme.primaryContainer
                                  ],
                                  activeFgColor: context
                                      .theme.colorScheme.onPrimaryContainer,
                                  inactiveBgColor:
                                      context.theme.colorScheme.tertiary,
                                  inactiveFgColor:
                                      context.theme.colorScheme.onTertiary,
                                  totalSwitches: distancesFilters.length,
                                  labels: distancesFilters,
                                  animate: true,
                                  animationDuration: 200,
                                  fontSize: 12,
                                  onToggle: (index) {
                                    distanceFiltersSwitchIndex.value =
                                        index ?? 0;
                                  },
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                            '${priceFilterStartValue.value == 0 && priceFilterEndValue.value == pricesFilters.length - 1 ? 'Any price' : '${pricesFilters[priceFilterStartValue.value]} ${priceFilterEndValue.value == priceFilterStartValue.value ? '' : '- ${pricesFilters[priceFilterEndValue.value]}'}'} '),
                                      ),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackShape:
                                              const RectangularSliderTrackShape(),
                                          trackHeight: 6.0,
                                          valueIndicatorShape:
                                              const RoundSliderOverlayShape(),
                                          rangeThumbShape:
                                              const RoundRangeSliderThumbShape(
                                                  enabledThumbRadius: 16),
                                          rangeValueIndicatorShape:
                                              const PaddleRangeSliderValueIndicatorShape(),
                                        ),
                                        child: RangeSlider(
                                          activeColor: context.theme.colorScheme
                                              .primaryContainer,
                                          inactiveColor: context
                                              .theme.colorScheme.tertiary,
                                          onChanged: (RangeValues values) {
                                            priceFilterStartValue.value =
                                                values.start.toInt();
                                            priceFilterEndValue.value =
                                                values.end.toInt();
                                          },
                                          max: pricesFilters.length - 1,
                                          divisions: pricesFilters.length - 1,
                                          values: RangeValues(
                                            priceFilterStartValue.value
                                                .toDouble(),
                                            priceFilterEndValue.value
                                                .toDouble(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),
            ],
            const SliverGap(height: 12),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12)
                  .copyWith(bottom: 112),
              sliver: MultiSliver(
                children: [
                  if (resultState.value == 0) ...[
                    SliverToBoxAdapter(
                      child: CardContainer(
                        borderRadius: BorderRadius.circular(16),
                        padding: const EdgeInsets.all(12),
                        child: state.searchedkeywords.isEmpty
                            ? ConstrainedBox(
                                constraints:
                                    const BoxConstraints.expand(height: 300),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Wrap(
                                alignment: WrapAlignment.spaceAround,
                                direction: Axis.horizontal,
                                clipBehavior: Clip.hardEdge,
                                spacing: 6,
                                runSpacing: 18,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: List.generate(
                                  state.searchedkeywords.length,
                                  (index) => Material(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.theme.colorScheme.tertiary,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      splashColor: context
                                          .theme.colorScheme.tertiaryContainer,
                                      onTap: () {
                                        textEditingController.text =
                                            state.searchedkeywords[index];
                                        resultState.value = 1;
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          state.searchedkeywords[index],
                                          style: context.textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                  if (resultState.value == 1) ...[
                    SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverFillRemaining(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 300),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (resultState.value == 2) ...[
                    SliverList.builder(
                        itemCount: state.searchedEvents.length,
                        itemBuilder: (context, index) {
                          final data =
                              SearchEventCardContainerData.fromEventComplete(
                            state.searchedEvents[index],
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: const EdgeInsets.all(12),
                              child: SearchEventCardContainer(
                                constraints: const BoxConstraints.expand(
                                  height: 220,
                                ),
                                data: data,
                              ),
                            ),
                          );
                        }),
                  ],
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

class SearchEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;
  final LatLng latlng;

  SearchEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
    required this.latlng,
  });

  static SearchEventCardContainerData fromEventComplete(EventComplete e) {
    return SearchEventCardContainerData(
      id: e.id!,
      title: e.title!,
      description: e.description!,
      startDate: e.startDate!,
      endDate: e.endDate!,
      location: e.venue?.address?.localizedAddressDisplay ?? '',
      organizers: [e.organizer?.title ?? ''],
      participants: [],
      imageUrl: e.imageUrl!,
      latlng: e.venue?.latLng ?? const LatLng(0, 0),
    );
  }
}

class SearchEventCardContainer extends HookWidget {
  const SearchEventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final SearchEventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.theme.colorScheme.primaryContainer;

    final child = LayoutBuilder(builder: (context, box) {
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < 160;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            maxLines: isSmallTall ? 3 : 1,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            maxLines: isSmallTall ? 3 : 1,
            overflow: TextOverflow.fade,
            style: context.textTheme.labelLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Iconify(
                Bx.bxs_map,
                color: color.lighten(0.7),
                size: 24,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  data.location,
                  maxLines: isSmallTall ? 3 : 1,
                  overflow: TextOverflow.fade,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isSmallTall) ...[
            Row(
              children: [
                Iconify(
                  Bx.calendar_event,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (!isSmall && !isSmallTall) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Iconify(
                  Bx.briefcase,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    data.organizers.join(' '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    });
    final heroTag = data.id + DateTime.now().toString();
    final extraJson = ExtraData(
      summary: NearbyDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
    return InkWell(
      onTap: () => navigationService.navigateTo(
        SearchScreen.name + NearbyDetailScreen.name,
        pathParameters: {
          NearbyDetailScreen.pathParamId: data.id,
        },
        extra: extraJson,
      ),
      child: Hero(
        tag: heroTag,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildEventCard(imageProvider, color, child),
          placeholder: (context, url) => _buildEventLoading(color),
          errorWidget: (context, url, error) =>
              _buildEventCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildEventLoading(Color color) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.1),
            color.darken(0.3),
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
