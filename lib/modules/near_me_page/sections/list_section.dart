import 'dart:math';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:debounce_hook/debounce_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/modules/near_me_page/cubits/near_by_cubit.dart';
import 'package:recive/modules/near_me_page/near_me_screen.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';

class NearMeScreenListViewContent extends HookWidget {
  const NearMeScreenListViewContent({
    super.key,
    required this.switchIndex,
    required this.bloc,
    required this.state,
  });

  final NearbyCubit bloc;
  final NearbyState state;
  final ValueNotifier<int> switchIndex;

  @override
  Widget build(BuildContext context) {
    final indexedKeyItems = state.nearbyArts.mapIndexed((i, e) {
      return {
        'key': GlobalKey(),
        'data': ArtCardContainerData.fromAbstractArt(e),
        'visiblity': 0,
      };
    }).toList();
    final isUpdating = useState(false);
    final indexUpdater = useDebounce<int>(
      debounceDelay: 100,
      callback: (index) {
        if (!isUpdating.value) {
          final i = index - 1 <= 0 ? 0 : index - 1;
          bloc.changeSelectedIndex(i);
        }
      },
    );

    final scrollController = useScrollController(keepScrollOffset: true);
    useBlocComparativeListener<NearbyCubit, NearbyState>(
      bloc,
      (_, state, context) {
        if (isUpdating.value || switchIndex.value == 1) {
          return;
        }
        isUpdating.value = true;
        scrollController
            .animateTo(
              state.preSelectedIndex * 236,
              duration: Duration(
                milliseconds: min(state.preSelectedIndex * 200 + 100, 500),
              ),
              curve: Curves.easeInOut,
            )
            .then((value) => isUpdating.value = false);
      },
      listenWhen: (previousState, currentState) =>
          previousState.preSelectedIndex != currentState.preSelectedIndex,
    );

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
            padding:
                EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2)
                    .copyWith(bottom: 112),
            sliver: SliverList.builder(
                addRepaintBoundaries: true,
                itemCount: indexedKeyItems.length,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index) {
                  final indexedItem = indexedKeyItems[index];
                  final data = indexedItem['data'];
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
                        borderRadius: kMediumBorderRadius,
                        padding: kTinyPadding,
                        child: ArtCardContainer(
                          constraints: const BoxConstraints.expand(height: 200),
                          data: data as ArtCardContainerData,
                          hero: NearMeScreen.name +
                              data.id +
                              DateTime.now().toString(),
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
