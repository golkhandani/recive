import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/sections/list_section.dart';
import 'package:recive/features/near_me_page/sections/map_section.dart';
import 'package:recive/ioc/geo_location_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NearMeScreen extends StatefulHookWidget {
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
    final state = useBlocBuilder(bloc);
    final geolocation = useLocationData(debugLabel: 'NearMeScreen');

    useEffect(() {
      print('geolocation != null ${geolocation}');
      if (geolocation != null)
        bloc.loadNearbyEvents(
          latitude: geolocation.latitude,
          longitude: geolocation.longitude,
          maxDistance: 10000,
          minDistance: 0,
        );
      return;
    }, [geolocation]);

    final switchIndex = useState(0);
    final pageController =
        PreloadPageController(initialPage: switchIndex.value);
    // usePageController(initialPage: switchIndex.value, viewportFraction: 1);
    final switchItems = ['Map', 'List'];
    const switchDuration = Duration(milliseconds: 300);
    final mapController = AnimatedMapController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 32;
        final mapSectionHeight = (contentHeight * 0.75) - 24 - 12;
        final listSectionHeight = (contentHeight * 0.25) - 24 - 12;
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Near me!',
            ),
            const SliverGap(height: 12),
            Builder(builder: (context) {
              print("state.nearbyEvents.length ${state.nearbyEvents.length}");
              if (state.loadingState != LoadingState.done ||
                  state.nearbyEvents.length == 0) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
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
                            pageController.animateToPage(
                              val,
                              duration: switchDuration,
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  const SliverGap(height: 12),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.transparent,
                      height: contentHeight + 100,
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
                              ),
                            ],
                          ),
                          NearMeScreenListViewContent(
                            switchIndex: switchIndex,
                            bloc: bloc,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        );
      }),
    );
  }
}
