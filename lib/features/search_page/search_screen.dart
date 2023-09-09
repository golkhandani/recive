import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/quick_search_header_component.dart';
import 'package:recive/features/search_page/widgets/search_event_card_container.dart';
import 'package:recive/features/search_page/widgets/search_event_card_container_data.dart';
import 'package:recive/features/search_page/widgets/tag_chip_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';

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
    final scrollController = useScrollController();
    useEffect(() {
      final query = textEditingController.text;
      if (query.length > 1) {
        bloc.searchedEvents(query, () => resultState.value = 2);
        scrollController.jumpTo(0);
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
          controller: scrollController,
          slivers: [
            const ScreenSafeAreaHeader(
              title: 'Search',
              elevation: false,
            ),
            SliverPinnedHeader(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.schema.tertiaryContainer,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0.2, 0),
                      blurRadius: 4,
                      color: context.colorScheme.shadow,
                    )
                  ],
                  borderRadius: BorderRadius.zero,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PinnedSearchHeader(
                        backgroundColor: context.schema.tertiaryContainer,
                        padding:
                            const EdgeInsets.all(12).copyWith(top: 0, right: 0),
                        height: 54,
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
                        child: Icon(
                          FluentIcons.filter_12_filled,
                          color: context.schema.onTertiaryContainer,
                          size: 36,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ...[
              _buildFilterSection(
                showFilters,
                dateFilters,
                dateFilterSwitchIndex,
                distancesFilters,
                distanceFiltersSwitchIndex,
                priceFilterStartValue,
                priceFilterEndValue,
                pricesFilters,
              ),
            ],
            const SliverGap(height: 12),
            SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2)
                      .copyWith(bottom: 112),
              sliver: MultiSliver(
                children: [
                  if (resultState.value == 0) ...[
                    _buildKeywords(
                      state,
                      context,
                      textEditingController,
                      resultState,
                    )
                  ],
                  if (resultState.value == 1) ...[
                    _buildLoading(),
                  ],
                  if (resultState.value == 2) ...[
                    _buildSearchResult(state),
                  ],
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  SliverList _buildSearchResult(SearchEventsState state) {
    return SliverList.builder(
        itemCount: state.searchedEvents.length,
        itemBuilder: (context, index) {
          final data = SearchEventCardContainerData.fromEventComplete(
            state.searchedEvents[index],
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: kTinyPadding,
              child: SearchEventCardContainer(
                constraints: const BoxConstraints.expand(
                  height: 220,
                ),
                data: data,
              ),
            ),
          );
        });
  }

  SliverCardContainer _buildLoading() {
    return SliverCardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: kTinyPadding,
      sliver: SliverFillRemaining(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(height: 300),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildKeywords(
      SearchEventsState state,
      BuildContext context,
      TextEditingController textEditingController,
      ValueNotifier<int> resultState) {
    return SliverToBoxAdapter(
      child: CardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: kTinyPadding,
        child: Builder(builder: (context) {
          return state.searchedkeywords.isEmpty
              ? ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 300),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RepaintBoundary(
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      direction: Axis.horizontal,
                      clipBehavior: Clip.hardEdge,
                      spacing: 4,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(
                        state.searchedkeywords.length,
                        (index) => TagChipContainer(
                          tag: state.searchedkeywords[index],
                          onTap: () {
                            textEditingController.text =
                                state.searchedkeywords[index];
                            resultState.value = 1;
                          },
                        ),
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }

  SliverPinnedHeader _buildFilterSection(
    ValueNotifier<bool> showFilters,
    List<String> dateFilters,
    ValueNotifier<int> dateFilterSwitchIndex,
    List<String> distancesFilters,
    ValueNotifier<int> distanceFiltersSwitchIndex,
    ValueNotifier<int> priceFilterStartValue,
    ValueNotifier<int> priceFilterEndValue,
    List<String> pricesFilters,
  ) {
    return SliverPinnedHeader(
      child: LayoutBuilder(builder: (context, box) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: showFilters.value
              ? Container(
                  padding: kTinyPadding,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: const Offset(0.2, 0),
                        blurRadius: 4,
                        color: context.colorScheme.primary.darken(0.2),
                      )
                    ],
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                      ToggleSwitch(
                        minWidth: (box.maxWidth - 32) / dateFilters.length,
                        initialLabelIndex: dateFilterSwitchIndex.value,
                        activeBgColor: [
                          context.theme.colorScheme.primaryContainer
                        ],
                        activeFgColor:
                            context.theme.colorScheme.onPrimaryContainer,
                        inactiveBgColor: context.theme.colorScheme.tertiary,
                        inactiveFgColor: context.theme.colorScheme.onTertiary,
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
                        minWidth: (box.maxWidth - 32) / distancesFilters.length,
                        initialLabelIndex: distanceFiltersSwitchIndex.value,
                        activeBgColor: [
                          context.theme.colorScheme.primaryContainer
                        ],
                        activeFgColor:
                            context.theme.colorScheme.onPrimaryContainer,
                        inactiveBgColor: context.theme.colorScheme.tertiary,
                        inactiveFgColor: context.theme.colorScheme.onTertiary,
                        totalSwitches: distancesFilters.length,
                        labels: distancesFilters,
                        animate: true,
                        animationDuration: 200,
                        fontSize: 12,
                        onToggle: (index) {
                          distanceFiltersSwitchIndex.value = index ?? 0;
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
                                trackShape: const RectangularSliderTrackShape(),
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
                                activeColor:
                                    context.theme.colorScheme.primaryContainer,
                                inactiveColor:
                                    context.theme.colorScheme.tertiary,
                                onChanged: (RangeValues values) {
                                  priceFilterStartValue.value =
                                      values.start.toInt();
                                  priceFilterEndValue.value =
                                      values.end.toInt();
                                },
                                max: pricesFilters.length - 1,
                                divisions: pricesFilters.length - 1,
                                values: RangeValues(
                                  priceFilterStartValue.value.toDouble(),
                                  priceFilterEndValue.value.toDouble(),
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
    );
  }
}
