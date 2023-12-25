import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/models/category.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/sections/list_section.dart';
import 'package:recive/modules/near_me_page/sections/map_section.dart';
import 'package:recive/modules/near_me_page/widgets/empty_result_snackbar.dart';
import 'package:recive/modules/near_me_page/widgets/near_me_filter_bar.dart';
import 'package:recive/modules/search_page/widgets/search_filter_bar.dart';
import 'package:recive/shared/constants/ui_constants.dart';
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

class _NearMeScreenState extends State<NearMeScreen> with TickerProviderStateMixin {
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
    final pageController = PreloadPageController(initialPage: switchIndex.value);
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
      color: context.colorTheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 24 - (NearMeScreen.enableQuery ? 72 : 0);
        final mapSectionHeight = (contentHeight * 0.75) - 36;
        final listSectionHeight = (contentHeight * 0.25) - 12;
        return CustomScrollView(
          slivers: [
            ScreenSafeAreaHeader(
              title: 'Near me!',
              elevation: false,
              children: [
                SearchFilterBar(
                  quickSearchBloc: quickSearchBloc,
                  textEditingController: textEditingController,
                  onFilterClicked: () => showFilters.value = !showFilters.value,
                  onSearchItemSelected: (text) => bloc.updateQueryFilter(text),
                  onSearchTextChanged: (text) => text.isEmpty ? bloc.updateQueryFilter(null) : null,
                )
              ],
            ),
            // COMING SOON !!!
            if (NearMeScreen.enableQuery) ...[
              SliverPinnedHeader(
                child: NearMeFilterBar(
                  showFilters: showFilters.value,
                  artTypeFilters: artTypeFilters,
                  queryFilter: state.queryFilter,
                  bloc: bloc,
                  textEditingController: textEditingController,
                  onFilterSelected: (ArtTypeFilter filter) {
                    bloc.updateQueryFilter(filter.category?.title);
                    textEditingController.text = filter.title;
                    showFilters.value = !showFilters.value;
                  },
                ),
              ),
            ],
            const SliverGap(height: 12),
            SliverToBoxAdapter(
              child: Center(
                child: ToggleSwitch(
                  minWidth: 200,
                  minHeight: 42.0,
                  fontSize: 16.0,
                  initialLabelIndex: switchIndex.value,
                  activeBgColor: [context.colorTheme.tabBarSelected],
                  activeFgColor: context.colorTheme.onTabBarSelected,
                  inactiveBgColor: context.colorTheme.tabBarUnselected,
                  inactiveFgColor: context.colorTheme.onTabBarUnselected,
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
              ),
            ),
            const SliverGap(height: 12),
            if (state.loadingState == LoadingState.loading)
              SliverPadding(
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
              )
            else
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: Stack(
                    children: [
                      Positioned(
                        child: SizedBox(
                          height: contentHeight + 120,
                          width: box.maxWidth,
                          child: PreloadPageView(
                            controller: pageController,
                            onPageChanged: (value) => switchIndex.value = value,
                            children: [
                              CustomScrollView(
                                physics: const NeverScrollableScrollPhysics(),
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
                          color: context.colorTheme.tertiaryContainer.withOpacity(0.4),
                          height: contentHeight,
                          child: kAnimatedLoadingBox,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
