import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/near_me_screen.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';

class NearbyCarouselContent extends HookWidget {
  const NearbyCarouselContent({
    super.key,
    required this.listSectionHeight,
    required this.bloc,
    required this.state,
  });

  final double listSectionHeight;
  final NearbyCubit bloc;
  final NearbyState state;

  List<ArtCardContainerData> calcItems() {
    return state.nearbyArts
        .map((e) => ArtCardContainerData.fromAbstractArt(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();

    final isUpdating = useState(false);
    List<ArtCardContainerData> items = calcItems();

    useBlocComparativeListener<NearbyCubit, NearbyState>(
      bloc,
      (_, state, context) {
        if (!isUpdating.value) {
          isUpdating.value = true;
          controller
              .animateToPage(state.preSelectedIndex)
              .then((value) => isUpdating.value = false);
        }
        isUpdating.value = false;
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedIndex != currentState.preSelectedIndex,
    );

    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: kMediumBorderRadius,
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: RepaintBoundary(
              child: LayoutBuilder(builder: (context, box) {
                // Warning: To stop rebuild issue
                // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
                final list = items
                    .mapIndexed(
                      (index, data) => ArtCardContainer(
                        hero: NearMeScreen.name +
                            data.id +
                            DateTime.now().toString(),
                        constraints: BoxConstraints.expand(
                          width: box.maxWidth / 1.4,
                        ),
                        data: data,
                      ),
                    )
                    .toList();
                return CarouselSlider(
                  items: list,
                  carouselController: controller,
                  options: CarouselOptions(
                    autoPlay: false,
                    disableCenter: true,
                    viewportFraction: 0.8,
                    height: listSectionHeight,
                    enableInfiniteScroll: true,
                    padEnds: true,
                    enlargeFactor: 0.24,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      if (!isUpdating.value &&
                          reason != CarouselPageChangedReason.controller) {
                        isUpdating.value = true;
                        bloc.changeSelectedIndex(index);
                      }
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
