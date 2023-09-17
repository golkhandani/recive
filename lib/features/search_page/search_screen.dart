import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/search_page/cubits/search_events_cubit.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/quick_search_header_component.dart';
import 'package:recive/features/search_page/widgets/search_event_card_container.dart';
import 'package:recive/features/search_page/widgets/search_event_card_container_data.dart';
import 'package:recive/features/search_page/widgets/tag_chip_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';

class DistanceFilter {
  final String title;
  final double? distance;
  DistanceFilter(this.title, this.distance);
}

class SearchScreen extends StatefulHookWidget {
  static const name = 'search';
  static const keywordQueryKey = 'keyword';
  const SearchScreen({
    super.key,
    this.keyword,
  });

  final String? keyword;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final textEditingController = useTextEditingController();

    final bloc = useBloc<SearchEventsCubit>();
    final state = useBlocBuilder(bloc);

    final quickSearchBloc = useBloc<QuickSearchHeaderBloc>();

    void textEditingListener() {
      final query = textEditingController.text;
      if (query.length > 1) {
        bloc.searchedEvents(query);
        scrollController.jumpTo(0);
      }
    }

    useEffect(() {
      bloc.loadSearchedKeywords();
      textEditingController.addListener(textEditingListener);
      if (widget.keyword != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          textEditingController.text = widget.keyword!;
        });
      }
      return () => textEditingController.dispose();
    }, []);

    final showFilters = useState(false);

    final distancesFilters = [
      DistanceFilter('Any distance', null),
      DistanceFilter('100 M', 100),
      DistanceFilter('300 M', 300),
      DistanceFilter('500 M', 500),
    ];

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
                        onSelect: (text) => bloc.resetSearchResult(),
                        onTextChanged: (text) =>
                            text.isNotEmpty ? null : bloc.resetSearchResult(),
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
                bloc,
                state,
                showFilters,
                distancesFilters,
              ),
            ],
            const SliverGap(height: 12),
            SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2)
                      .copyWith(bottom: 112),
              sliver: MultiSliver(
                children: [
                  if (state.loadingKeywordsState == LoadingState.loading ||
                      state.loadingState == LoadingState.loading) ...[
                    _buildLoading()
                  ],
                  if (state.loadingKeywordsState == LoadingState.done &&
                      state.searchedEvents.isEmpty) ...[
                    _buildKeywords(
                      state,
                      context,
                      textEditingController,
                    )
                  ],
                  if (state.loadingState == LoadingState.done) ...[
                    _buildSearchResult(state),
                  ]
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
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        itemCount: state.searchedEvents.length,
        itemBuilder: (context, index) {
          final data = SearchEventCardContainerData.fromPackageAbstract(
            state.searchedEvents[index],
          );
          return RepaintBoundary(
            child: Padding(
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
            ),
          );
        });
  }

  Widget _buildLoading() {
    return kSliverFillLoading;
  }

  SliverToBoxAdapter _buildKeywords(
    SearchEventsState state,
    BuildContext context,
    TextEditingController textEditingController,
  ) {
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
    SearchEventsCubit bloc,
    SearchEventsState state,
    ValueNotifier<bool> showFilters,
    List<DistanceFilter> distancesFilters,
  ) {
    return SliverPinnedHeader(
      child: LayoutBuilder(builder: (context, box) {
        return RepaintBoundary(
          child: AnimatedSize(
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
                        ToggleSwitch(
                          minWidth:
                              (box.maxWidth - 32) / distancesFilters.length,
                          initialLabelIndex: distancesFilters.indexWhere(
                            (element) =>
                                element.distance == state.distanceFilter,
                          ),
                          activeBgColor: [
                            context.theme.colorScheme.primaryContainer
                          ],
                          activeFgColor:
                              context.theme.colorScheme.onPrimaryContainer,
                          inactiveBgColor: context.theme.colorScheme.tertiary,
                          inactiveFgColor: context.theme.colorScheme.onTertiary,
                          totalSwitches: distancesFilters.length,
                          labels: distancesFilters.map((e) => e.title).toList(),
                          animate: true,
                          animationDuration: 200,
                          fontSize: 12,
                          onToggle: (index) {
                            bloc.updateDistanceFilter(
                              distancesFilters[index ?? 0].distance?.toInt(),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }),
    );
  }
}
