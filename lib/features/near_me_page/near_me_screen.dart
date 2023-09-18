import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/sections/list_section.dart';
import 'package:recive/features/near_me_page/sections/map_section.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/features/search_page/widgets/quick_search_header/quick_search_header_component.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';

class NearMeScreen extends StatefulHookWidget {
  static const enableQuery = false;
  static const name = 'near_me';
  const NearMeScreen({super.key});

  @override
  State<NearMeScreen> createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<NearbyEventsCubit>();
    final state = useBlocComparativeBuilder(bloc, buildWhen: (old, updated) {
      return true;
    });
    final geolocation = useLocationData(debugLabel: 'NearMeScreen');
    final textEditingController = useTextEditingController();

    useEffect(() {
      locator.logger.d('geolocation != null $geolocation');
      if (geolocation != null) {
        bloc.loadNearbyEvents(
          latitude: geolocation.latitude,
          longitude: geolocation.longitude,
          maxDistance: 100000,
          minDistance: 0,
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

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight -
            context.invisibleHeight -
            24 -
            24 -
            (NearMeScreen.enableQuery ? 72 : 0);
        final mapSectionHeight = (contentHeight * 0.75) - 24;
        final listSectionHeight = (contentHeight * 0.25) - 24;
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const ScreenSafeAreaHeader(
              title: 'Near me!',
              elevation: !NearMeScreen.enableQuery,
            ),
            // COMING SOON !!!
            if (NearMeScreen.enableQuery) ...[
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
                          padding: const EdgeInsets.all(12)
                              .copyWith(top: 0, right: 0),
                          height: 54,
                          bloc: quickSearchBloc,
                          onSelect: (text) => {}, //  bloc.resetSearchResult(),
                          onTextChanged: (text) => {},
                          // text.isNotEmpty ? null : bloc.resetSearchResult(),
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
              _buildFilterSection(showFilters),
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
                            context.theme.colorScheme.primaryContainer
                          ],
                          activeFgColor:
                              context.theme.colorScheme.onPrimaryContainer,
                          inactiveBgColor: context.theme.colorScheme.tertiary,
                          inactiveFgColor: context.theme.colorScheme.onTertiary,
                          totalSwitches: 2,
                          labels: switchItems,
                          animate: true,
                          animationDuration: switchDuration.inMilliseconds,
                          onToggle: (index) {
                            final val = index ?? 0;
                            switchIndex.value = val;
                            if (state.nearbyEvents.isNotEmpty) {
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
                    if (state.loadingState != LoadingState.done) {
                      return SliverPadding(
                        padding: kTinyPadding,
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height: contentHeight - 24,
                            child: CardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: kTinyPadding,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    if (state.nearbyEvents.isEmpty) {
                      return SliverPadding(
                        padding: kTinyPadding,
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height: contentHeight - 24,
                            child: CardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: kTinyPadding,
                              child: const Center(
                                child: Text("No Art has been found!"),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return SliverToBoxAdapter(
                      child: RepaintBoundary(
                        child: Container(
                          color: Colors.transparent,
                          height: contentHeight + 120,
                          width: box.maxWidth,
                          child: PreloadPageView(
                            //  allowImplicitScrolling: false,
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
    ValueNotifier<bool> showFilters,
  ) {
    return SliverPinnedHeader(
      child: RepaintBoundary(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: showFilters.value
              ? Container(
                  height: 200,
                  color: Colors.red,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
