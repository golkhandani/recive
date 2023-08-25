import 'dart:math';

import 'package:collection/collection.dart';
import 'package:debounce_hook/debounce_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/features/near_me_page/cubits/near_by_events_cubit.dart';
import 'package:recive/features/near_me_page/sections/map_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NearMeScreenListViewContent extends StatefulHookWidget {
  const NearMeScreenListViewContent({
    super.key,
    required this.switchIndex,
    required this.bloc,
  });

  final NearbyEventsCubit bloc;
  final ValueNotifier<int> switchIndex;

  @override
  State<NearMeScreenListViewContent> createState() =>
      _NearMeScreenListViewContentState();
}

class _NearMeScreenListViewContentState
    extends State<NearMeScreenListViewContent> {
  @override
  Widget build(BuildContext context) {
    final state = useBlocBuilder(widget.bloc);
    final indexedKeyItems = state.nearbyEvents.mapIndexed((i, e) {
      return {
        'key': GlobalKey(),
        'data': EventCardContainerData.fromFeaturedEvent(e),
        'visiblity': 0,
      };
    }).toList();

    final scrollController = useScrollController(keepScrollOffset: true);
    final isUpdating = useState(false);
    useBlocComparativeListener<NearbyEventsCubit, NearbyEventsState>(
      widget.bloc,
      (_, state, context) {
        if (isUpdating.value || widget.switchIndex.value == 1) {
          return;
        }
        isUpdating.value = true;
        scrollController
            .animateTo(
              state.preSelectedEventIndex * 236,
              duration: Duration(
                milliseconds: min(state.preSelectedEventIndex * 200 + 100, 500),
              ),
              curve: Curves.easeInOut,
            )
            .then((value) => isUpdating.value = false);
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedEventIndex !=
          currentState.preSelectedEventIndex,
    );

    final indexUpdater = useDebounce<int>(
        debounceDelay: 100,
        callback: (index) {
          if (!isUpdating.value) {
            final i = index - 1 <= 0 ? 0 : index - 1;
            widget.bloc.changeSelectedIndex(i);
          }
        });

    return NotificationListener<ScrollNotification>(
      onNotification: (sn) {
        if (sn is ScrollStartNotification) {
          isUpdating.value = true;
        } else if (sn is ScrollUpdateNotification) {
        } else if (sn is ScrollEndNotification) {
          isUpdating.value = false;
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12)
                .copyWith(bottom: 112),
            sliver: SliverList.builder(
                itemCount: indexedKeyItems.length,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  final indexedItem = indexedKeyItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VisibilityDetector(
                      key: indexedItem['key'] as GlobalKey,
                      onVisibilityChanged: (VisibilityInfo info) {
                        if (!isUpdating.value && info.visibleFraction == 1) {
                          indexUpdater.onChanged(index);
                        }
                      },
                      child: CardContainer(
                        borderRadius: BorderRadius.circular(16),
                        padding: const EdgeInsets.all(12),
                        child: EventCardContainer(
                          constraints: const BoxConstraints.expand(height: 200),
                          data: indexedItem['data'] as EventCardContainerData,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
