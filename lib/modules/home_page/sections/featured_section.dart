import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/featured_page/cubits/featured_cubit.dart';
import 'package:recive/modules/featured_page/featured_screen.dart';
import 'package:recive/modules/home_page/home_screen.dart';
import 'package:recive/modules/home_page/widgets/see_more_button.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';

class HomePageFeaturedSection extends HookWidget {
  const HomePageFeaturedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<FeaturedCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeatured();
      return;
    }, []);

    return state.loadingState == LoadingState.loading
        ? kSkeletonSectionLoadingBox
        : MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: Text(
                  "Featured Art",
                  style: context.textTheme.onBackground.subtitleLarge.style,
                ),
              ),
              const SliverGap(height: 12),
              SliverCardContainer(
                color: context.colorTheme.secondary,
                borderRadius: kMediumBorderRadius,
                padding: kTinyPadding.copyWith(right: 0, bottom: 0),
                sliver: MultiSliver(
                  children: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.loadingState == LoadingState.loading
                            ? 6
                            : state.artAbstractItemsSpotlight.length + 1,
                        (context, index) {
                          if (index == state.artAbstractItemsSpotlight.length) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: kTinyPadding.bottom,
                                right: kTinyPadding.right,
                              ),
                              child: SeeMoreButton(
                                constraints: const BoxConstraints.expand(),
                                onTap: () => navigationService.moveTo(
                                  FeaturedScreen.name,
                                ),
                              ),
                            );
                          }

                          final data = ArtCardContainerData.fromAbstractArt(
                            state.artAbstractItemsSpotlight[index],
                          );
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: kTinyPadding.bottom,
                              right: kTinyPadding.right,
                            ),
                            child: ArtCardContainer(
                              hero: HomeScreen.name + data.id,
                              constraints: const BoxConstraints.expand(),
                              data: data,
                            ),
                          );
                        },
                      ),
                      gridDelegate: SliverStairedGridDelegate(
                        startCrossAxisDirectionReversed: true,
                        pattern: const [
                          StairedGridTile(1, 1.4),
                          StairedGridTile(0.4, 0.5),
                          StairedGridTile(0.6, 0.75),
                          StairedGridTile(0.4, 0.5),
                          StairedGridTile(0.6, 0.75),
                          StairedGridTile(1, 6),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
