import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/components/quick_search_header/quick_search_header_component.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/models/category.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/sections/list_section.dart';
import 'package:recive/modules/near_me_page/sections/map_section.dart';
import 'package:recive/modules/near_me_page/widgets/empty_result_snackbar.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/geo_location_service.dart';

class ArtTypeFilter {
  final String title;
  final Category? category;
  ArtTypeFilter(this.title, this.category);
}

class NearMeScreen extends StatefulHookWidget {
  static const enableQuery = true;
  static const name = 'near_me';
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen>
    with TickerProviderStateMixin {
  void showEmptySnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(emptySearchResultSnackbar);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = context.read<CategoriesCubit>();
    final categoriesState = useBlocBuilder(categoriesBloc);
    final bloc = useBloc<NearbyCubit>();
    final state = useBlocComparativeBuilder(bloc, buildWhen: (old, updated) {
      return true;
    });
    final geolocation = useLocationData(debugLabel: 'NearMeScreen');
    final textEditingController = useTextEditingController();

    useEffect(() {
      locator.logger.d('geolocation != null $geolocation');
      if (geolocation != null) {
        bloc.loadNearbyArts(
          latitude: geolocation.latitude,
          longitude: geolocation.longitude,
          maxDistance: 100000,
          minDistance: 0,
          callback: (isEmpty) => isEmpty ? showEmptySnackBar() : null,
        );
      }
      return;
    }, [geolocation]);

    final switchIndex = useState(0);
    final pageController =
        PreloadPageController(initialPage: switchIndex.value);
    final switchItems = ['Map', 'List'];
    const switchDuration = Duration(milliseconds: 300);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    final quickSearchBloc = useBloc<QuickSearchHeaderBloc>();
    final showFilters = useState(false);
    final artTypeFilters = [
      ArtTypeFilter('All', null),
      ...categoriesState.categories.map(
        (e) => ArtTypeFilter(e.title, e),
      ),
    ];

    return ColoredBox(
      color: context.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight -
            context.invisibleHeight -
            24 -
            24 -
            (NearMeScreen.enableQuery ? 72 : 0);
        final mapSectionHeight = (contentHeight * 0.75) - 24;
        final listSectionHeight = (contentHeight * 0.25) - 24;
        return CustomScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ScreenSafeAreaHeader(
              title: 'Near me!',
              backgroundColor: context.theme.colorScheme.tertiaryContainer,
              // elevation: !NearMeScreen.enableQuery,
            ),
            // // COMING SOON !!!
            if (NearMeScreen.enableQuery) ...[
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
                          padding: const EdgeInsets.all(12)
                              .copyWith(top: 0, right: 0),
                          height: 54,
                          bloc: quickSearchBloc,
                          onSelect: (text) => bloc.updateQueryFilter(text),
                          onTextChanged: (text) => text.isEmpty
                              ? bloc.updateQueryFilter(null)
                              : null,
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
              _buildFilterSection(
                bloc,
                state,
                textEditingController,
                showFilters,
                artTypeFilters,
              ),
            ],

            const SliverGap(height: 12),
            Builder(builder: (context) {
              return MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: LayoutBuilder(builder: (context, box) {
                      return Center(
                        child: ToggleSwitch(
                          minWidth: box.maxWidth / 4,
                          minHeight: 42.0,
                          fontSize: 16.0,
                          initialLabelIndex: switchIndex.value,
                          activeBgColor: [
                            context.theme.colorScheme.tertiaryContainer
                          ],
                          activeFgColor:
                              context.theme.colorScheme.onTertiaryContainer,
                          inactiveBgColor:
                              context.theme.colorScheme.onTertiaryContainer,
                          inactiveFgColor:
                              context.theme.colorScheme.tertiaryContainer,
                          totalSwitches: 2,
                          labels: switchItems,
                          animate: true,
                          animationDuration: switchDuration.inMilliseconds,
                          onToggle: (index) {
                            final val = index ?? 0;
                            switchIndex.value = val;
                            if (state.nearbyArts.isNotEmpty) {
                              pageController.animateToPage(
                                val,
                                duration: switchDuration,
                                curve: Curves.easeIn,
                              );
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SliverGap(height: 12),
                  Builder(builder: (context) {
                    if (state.loadingState == LoadingState.loading) {
                      return SliverPadding(
                        padding: kTinyPadding,
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height: contentHeight - 24,
                            child: CardContainer(
                              borderRadius: kMediumBorderRadius,
                              padding: kTinyPadding,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state.nearbyArts.isEmpty &&
                        state.loadingState != LoadingState.done) {
                      return SliverPadding(
                        padding: kTinyPadding,
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height: contentHeight - 24,
                            child: CardContainer(
                              borderRadius: kMediumBorderRadius,
                              padding: kTinyPadding,
                              child: Center(
                                child: Text(
                                  "No Art has been found!",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color:
                                        context.colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: RepaintBoundary(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                color: Colors.transparent,
                                height: contentHeight + 120,
                                width: box.maxWidth,
                                child: PreloadPageView(
                                  controller: pageController,
                                  onPageChanged: (value) =>
                                      switchIndex.value = value,
                                  children: [
                                    CustomScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      slivers: [
                                        NearMeScreenMapViewContent(
                                          switchIndex: switchIndex,
                                          switchItems: switchItems,
                                          mapSectionHeight: mapSectionHeight,
                                          listSectionHeight: listSectionHeight,
                                          mapController: mapController,
                                          bloc: bloc,
                                          state: state,
                                        ),
                                      ],
                                    ),
                                    NearMeScreenListViewContent(
                                      switchIndex: switchIndex,
                                      bloc: bloc,
                                      state: state,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (state.loadingState == LoadingState.updating)
                              Container(
                                color: context.colorScheme.tertiaryContainer
                                    .withOpacity(0.4),
                                height: contentHeight,
                                child: kAnimatedLoadingBox,
                              )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ],
        );
      }),
    );
  }

  Widget _buildFilterSection(
    NearbyCubit bloc,
    NearbyState state,
    TextEditingController textEditingController,
    ValueNotifier<bool> showFilters,
    List<ArtTypeFilter> artTypeFilters,
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
                      color: context.theme.colorScheme.tertiaryContainer,
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
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: kTinyPadding,
                          child: Text(
                            'Popular Categories:',
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return artTypeFilters.isEmpty
                                ? ConstrainedBox(
                                    constraints: const BoxConstraints.expand(
                                        height: 300),
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: List.generate(
                                        artTypeFilters.length,
                                        (index) => SizedBox(
                                          width: (box.maxWidth - 42) / 3,
                                          height: 64,
                                          child: FilterTagChipContainer(
                                            backgroundColor:
                                                artTypeFilters[index]
                                                            .category
                                                            ?.title ==
                                                        state.queryFilter
                                                    ? context
                                                        .colorScheme.primary
                                                    : null,
                                            color: artTypeFilters[index]
                                                        .category
                                                        ?.title ==
                                                    state.queryFilter
                                                ? context.colorScheme.onPrimary
                                                : null,
                                            tag: artTypeFilters[index].title,
                                            onTap: () {
                                              bloc.updateQueryFilter(
                                                artTypeFilters[index]
                                                    .category
                                                    ?.title,
                                              );
                                              textEditingController.text =
                                                  artTypeFilters[index].title;
                                              showFilters.value = false;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
