import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/featured_page/widgets/featured_event_card_container.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:recive/enums/loading_state.dart';

class HomePageFeaturedEventsSection extends HookWidget {
  const HomePageFeaturedEventsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<FeatureEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeaturedEvents();
      return;
    }, []);

    return context.checkLoadingState(state.loadingState) ??
        MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                "Featured Events",
                style: context.textTheme.headlineSmall,
              ),
            ),
            const SliverGap(height: 12),
            SliverCardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: kTinyPadding,
              sliver: Builder(
                builder: (context) {
                  if (state.loadingState == LoadingState.loading) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 600,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return MultiSliver(
                    children: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.featuredEventsSpotlight.length +
                                1, (context, index) {
                          if (index == state.featuredEventsSpotlight.length) {
                            return SeeMoreButton(
                              constraints: const BoxConstraints.expand(),
                              onTap: () =>
                                  navigationService.pushTo(FeaturedScreen.name),
                            );
                          }

                          final data =
                              FeaturedEventCardContainerData.fromFeaturedEvent(
                            state.featuredEventsSpotlight[index],
                          );
                          return FeaturedEventCardContainer(
                            parentPathParams: const {},
                            parentRoute: HomeScreen.name,
                            constraints: const BoxConstraints.expand(),
                            data: data,
                          );
                        }),
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          repeatPattern: QuiltedGridRepeatPattern.same,
                          pattern: const [
                            QuiltedGridTile(3, 4),
                            QuiltedGridTile(3, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(1, 2),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
  }
}
