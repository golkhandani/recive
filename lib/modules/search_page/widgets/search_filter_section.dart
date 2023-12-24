import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:recive/modules/search_page/cubits/search_cubit.dart';
import 'package:recive/modules/search_page/widgets/tag_chip_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class DistanceFilter {
  final String title;
  final double? distance;
  DistanceFilter(this.title, this.distance);
}

class SearchFilterSection extends HookWidget {
  const SearchFilterSection({
    super.key,
    required this.bloc,
    required this.showFilters,
    required this.selectedDistanceFilter,
    required this.searchedkeywords,
    required this.onKeywordTap,
  });

  final SearchCubit bloc;
  final ValueNotifier<bool> showFilters;
  final int? selectedDistanceFilter;
  final List<String> searchedkeywords;
  final void Function(String) onKeywordTap;

  @override
  Widget build(BuildContext context) {
    final distancesFilters = [
      DistanceFilter('Any', null),
      DistanceFilter('100 M', 100),
      DistanceFilter('300 M', 300),
      DistanceFilter('500 M', 500),
    ];
    return SliverPinnedHeader(
      child: LayoutBuilder(builder: (context, box) {
        return RepaintBoundary(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            child: showFilters.value
                ? Container(
                    padding: kTinyPadding,
                    decoration: BoxDecoration(
                      color: context.colorTheme.navBackground,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(0.2, 0),
                          blurRadius: 4,
                          color: context.colorTheme.navBackground.darken(0.2),
                        )
                      ],
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: kTinyPadding,
                          child: Text(
                            'Begin to end distance: ',
                            style: context.textTheme.bodySmall.style,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        ToggleSwitch(
                          minWidth: (box.maxWidth - 32) / distancesFilters.length,
                          initialLabelIndex: distancesFilters.indexWhere(
                            (element) => element.distance == selectedDistanceFilter,
                          ),
                          activeBgColor: [context.colorTheme.primary],
                          activeFgColor: context.colorTheme.onPrimary,
                          inactiveBgColor: context.colorTheme.tertiaryContainer,
                          inactiveFgColor: context.colorTheme.onTertiaryContainer,
                          totalSwitches: distancesFilters.length,
                          labels: distancesFilters.map((e) => e.title).toList(),
                          animate: true,
                          animationDuration: 200,
                          fontSize: 12,
                          onToggle: (index) {
                            bloc.updateDistanceFilter(
                              distancesFilters[index ?? 0].distance?.toInt(),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: kTinyPadding,
                          child: Text(
                            'Popular tags:',
                            style: context.textTheme.bodySmall.style,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        searchedkeywords.isEmpty
                            ? ConstrainedBox(
                                constraints: const BoxConstraints.expand(
                                  height: 300,
                                ),
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
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: List.generate(
                                    searchedkeywords.length,
                                    (index) => SizedBox(
                                      width: (box.maxWidth - 42) / 3,
                                      height: 64,
                                      child: FilterTagChipContainer(
                                        backgroundColor: context.colorTheme.tertiaryContainer,
                                        color: context.colorTheme.onTertiaryContainer,
                                        tag: searchedkeywords[index],
                                        onTap: () => onKeywordTap(
                                          searchedkeywords[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
