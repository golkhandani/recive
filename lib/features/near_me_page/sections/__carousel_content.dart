part of 'map_section.dart';

class _CarouselContent extends HookWidget {
  const _CarouselContent({
    required this.switchIndex,
    required this.listSectionHeight,
    required this.mapController,
    required this.bloc,
    required this.state,
  });

  final ValueNotifier<int> switchIndex;
  final double listSectionHeight;
  final AnimatedMapController mapController;
  final NearbyEventsCubit bloc;
  final NearbyEventsState state;

  List<EventCardContainerData> calcItems() {
    return state.nearbyEvents
        .map((e) => EventCardContainerData.fromFeaturedEvent(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();

    final isUpdating = useState(false);
    List<EventCardContainerData> items = calcItems();

    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      bloc,
      (_, state, context) {
        if (!isUpdating.value) {
          isUpdating.value = true;
          controller.animateToPage(state.preSelectedEventIndex);
        }
        // mapController
        //     .animateTo(
        //       dest: state.nearbyEvents[state.preSelectedEventIndex].latLng,
        //     )
        //     .then((value) => isUpdating.value = false);
        isUpdating.value = false;
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedEventIndex !=
          currentState.preSelectedEventIndex,
    );

    return MultiSliver(
      children: [
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: kTinyPadding,
          sliver: SliverToBoxAdapter(
            child: RepaintBoundary(
              child: LayoutBuilder(builder: (context, box) {
                // Warning: To prevent rebuild issue
                // https://github.com/serenader2014/flutter_carousel_slider/issues/187#issuecomment-741112872
                final list = items
                    .mapIndexed((index, data) => EventCardContainer(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 1.4,
                          ),
                          data: data,
                        ))
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
