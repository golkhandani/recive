import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/components/quick_search_header/quick_search_header_component.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/package_page/models/art_route_model.dart';
import 'package:recive/modules/package_page/widgets/art_route_card_container_data.dart';
import 'package:recive/modules/package_page/widgets/art_route_expanded_card_container.dart';
import 'package:recive/modules/search_page/cubits/search_cubit.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

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
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final textEditingController = useTextEditingController();

    final bloc = useBloc<SearchCubit>();
    final state = useBlocBuilder(bloc);

    final quickSearchBloc = useBloc<QuickSearchHeaderBloc>();

    useBlocComparativeListener<SearchCubit, SearchState>(
      bloc,
      (bloc, current, context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          for (var item in current.searchedItems) {
            final index = current.searchedItems.indexOf(item);
            _listKey.currentState?.insertItem(
              index,
              duration: const Duration(milliseconds: 200),
            );
          }
        });
      },
      listenWhen: (o, n) => o.searchedItems.length != n.searchedItems.length,
    );

    void textEditingListener() {
      final query = textEditingController.text;
      if (query.length > 1 && scrollController.hasClients) {
        bloc.loadSearchedItems(query);
        scrollController.jumpTo(0);
      }
    }

    void loadMoreOnScroll() {
      if (state.loadingState == LoadingState.loading ||
          state.loadingState == LoadingState.updating) {
        return;
      }
      if (scrollController.offset + 10 >
          scrollController.position.maxScrollExtent) {
        bloc.loadMoreSearchedItems();
      }
    }

    useEffect(() {
      bloc.loadSearchedKeywords();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        textEditingController.addListener(textEditingListener);
        scrollController.addListener(loadMoreOnScroll);

        if (widget.keyword != null) {
          textEditingController.text = widget.keyword!;
        }
      });

      bloc.loadSearchedItems(widget.keyword ?? '');
      return () {
        scrollController.dispose();
      };
    }, []);

    useEffect(
      () {
        textEditingController.text = widget.keyword ?? '';
        bloc.loadSearchedItems(widget.keyword);
        return;
      },
      [widget.keyword],
    );

    final showFilters = useState(false);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            const ScreenSafeAreaHeader(
              title: 'Search Routes',
              elevation: false,
            ),
            SliverPinnedHeader(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.schema.tertiaryContainer,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0.1, 0.1),
                      blurRadius: 0.5,
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
                        padding: const EdgeInsets.only(bottom: 12, left: 12),
                        height: 54,
                        bloc: quickSearchBloc,
                        onSelect: (text) => bloc.loadSearchedItems(text),
                        onTextChanged: (text) => bloc.loadSearchedItems(text),
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
              SearchFilterSection(
                bloc: bloc,
                showFilters: showFilters,
                selectedDistanceFilter: state.distanceFilter,
                searchedkeywords: state.searchedkeywords,
                onKeywordTap: (keyword) {
                  textEditingController.text = keyword;
                  showFilters.value = false;
                },
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
                    kSkeletonSectionLoadingBox,
                  ],
                  if (state.loadingState == LoadingState.done ||
                      state.loadingState == LoadingState.updating) ...[
                    SearchResultAnimatedList(
                      listKey: _listKey,
                      initialItem: state.searchedItems,
                    )
                  ]
                ],
              ),
            ),
            if (state.loadingState == LoadingState.updating)
              SliverPadding(
                padding: EdgeInsets.only(bottom: context.footerHeight + 16),
                sliver: kSliverBoxAnimatedLoading,
              ),
          ],
        );
      }),
    );
  }
}

class SearchFilterSection extends HookWidget {
  const SearchFilterSection({
    super.key,
    required this.bloc,
    required this.showFilters,
    required this.selectedDistanceFilter,
    required this.searchedkeywords,
    required this.onKeywordTap,
  });

  final SearchCubit bloc;
  final ValueNotifier<bool> showFilters;
  final int? selectedDistanceFilter;
  final List<String> searchedkeywords;
  final void Function(String) onKeywordTap;

  @override
  Widget build(BuildContext context) {
    final distancesFilters = [
      DistanceFilter('Any', null),
      DistanceFilter('100 M', 100),
      DistanceFilter('300 M', 300),
      DistanceFilter('500 M', 500),
    ];
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
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: kTinyPadding,
                          child: Text(
                            'Begin to end distance: ',
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        ToggleSwitch(
                          minWidth:
                              (box.maxWidth - 32) / distancesFilters.length,
                          initialLabelIndex: distancesFilters.indexWhere(
                            (element) =>
                                element.distance == selectedDistanceFilter,
                          ),
                          activeBgColor: [
                            context.theme.colorScheme.primaryContainer
                          ],
                          activeFgColor: context.theme.colorScheme.primary,
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
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: kTinyPadding,
                          child: Text(
                            'Popular tags:',
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        searchedkeywords.isEmpty
                            ? ConstrainedBox(
                                constraints: const BoxConstraints.expand(
                                  height: 300,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : RepaintBoundary(
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  direction: Axis.horizontal,
                                  clipBehavior: Clip.hardEdge,
                                  spacing: 4,
                                  runSpacing: 8,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: List.generate(
                                    searchedkeywords.length,
                                    (index) => SizedBox(
                                      width: (box.maxWidth - 42) / 3,
                                      height: 64,
                                      child: FilterTagChipContainer(
                                        tag: searchedkeywords[index],
                                        onTap: () => onKeywordTap(
                                          searchedkeywords[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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

class SearchResultAnimatedList extends StatelessWidget {
  const SearchResultAnimatedList({
    super.key,
    required this.listKey,
    required this.initialItem,
  });

  final GlobalKey<SliverAnimatedListState> listKey;
  final List<ArtRouteAbstractModel> initialItem;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      itemBuilder: (context, index, animation) {
        // Note: handle pre-view scroll items
        if (index > initialItem.length - 1) {
          return const SizedBox();
        }
        final data = ArtRouteContainerData.fromAbstract(
          initialItem[index],
        );
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ArtRouteExpandedCardContainer(
            data: data,
          ),
        );
      },
    );
  }
}
