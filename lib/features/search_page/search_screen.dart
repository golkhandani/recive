import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/archived/featured_page/quick_search_header/quick_search_header_component.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/sliver_header_delegate.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

List<String> randomWords = [
  "Flutter",
  "Dart",
  "Widget",
  "App",
  "Mobile",
  "UI",
  "Button",
  "Text",
  "Image",
  "Animation",
  "State",
  "ListView",
  "Grid",
  "Navigation",
  "AppBar",
  "Scaffold",
  "Container",
  "Color",
  "Gesture",
  "Layout",
  "Responsive",
  "Card",
  "Dialog",
  "Route",
  "Input",
  "Icon",
  "Snackbar",
  "Progress",
  "Carousel",
  "TabBar",
  "Flutter",
  "Dart",
  "Widget",
  "App",
  "Mobile",
  "UI",
  "Button",
  "Text",
  "Image",
  "Animation",
  "State",
  "ListView",
  "Grid",
  "Navigation",
  "AppBar",
  "Scaffold",
  "Container",
  "Color",
  "Gesture",
  "Layout",
  "Responsive",
  "Card",
  "Dialog",
  "Route",
  "Input",
  "Icon",
  "Snackbar",
  "Progress",
  "Carousel",
  "TabBar",
];

class SearchScreen extends HookWidget {
  static const name = 'search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultState = useState(0);
    final textEditingController = useTextEditingController();

    final showFilters = useState(false);

    final dateFilters = ['Any time', 'Today', 'This Week', 'This Month'];
    final dateFilterSwitchIndex = useState(0);

    final distancesFilters = ['Any where', '1 KM', '5 KM', '15 KM'];
    final distanceFiltersSwitchIndex = useState(0);

    final pricesFilters = ['Free', '\$', '\$\$', '\$\$\$\$'];
    final priceFilterStartValue = useState(0);
    final priceFilterEndValue = useState(pricesFilters.length - 1);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight =
            box.maxHeight - context.invisibleHeight - 24 - 56 - 12 - 24;
        return CustomScrollView(
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Search',
            ),
            SliverPinnedHeader(
              child: ColoredBox(
                color: context.theme.colorScheme.primary,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PinnedSearchHeader(
                        padding:
                            const EdgeInsets.all(12).copyWith(top: 0, right: 0),
                        height: 56,
                        onSelect: (text) => resultState.value = 1,
                        onTextChanged: (text) =>
                            text.isNotEmpty ? null : resultState.value = 0,
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
                        child: Iconify(
                          Mdi.filter,
                          color: context.schema.primaryContainer,
                          size: 36,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ...[
              SliverPinnedHeader(
                child: LayoutBuilder(builder: (context, box) {
                  print("kbox ${box}");
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    child: showFilters.value
                        ? Container(
                            color: context.theme.colorScheme.primary,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                                ToggleSwitch(
                                  minWidth:
                                      (box.maxWidth - 32) / dateFilters.length,
                                  initialLabelIndex:
                                      dateFilterSwitchIndex.value,
                                  activeBgColor: [
                                    context.theme.colorScheme.primaryContainer
                                  ],
                                  activeFgColor: context
                                      .theme.colorScheme.onPrimaryContainer,
                                  inactiveBgColor:
                                      context.theme.colorScheme.tertiary,
                                  inactiveFgColor:
                                      context.theme.colorScheme.onTertiary,
                                  totalSwitches: dateFilters.length,
                                  labels: dateFilters,
                                  animate: true,
                                  fontSize: 12,
                                  animationDuration: 200,
                                  onToggle: (index) {
                                    dateFilterSwitchIndex.value = index ?? 0;
                                    print('switched to: $index');
                                  },
                                ),
                                const SizedBox(height: 12),
                                // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                                ToggleSwitch(
                                  minWidth: (box.maxWidth - 32) /
                                      distancesFilters.length,
                                  initialLabelIndex:
                                      distanceFiltersSwitchIndex.value,
                                  activeBgColor: [
                                    context.theme.colorScheme.primaryContainer
                                  ],
                                  activeFgColor: context
                                      .theme.colorScheme.onPrimaryContainer,
                                  inactiveBgColor:
                                      context.theme.colorScheme.tertiary,
                                  inactiveFgColor:
                                      context.theme.colorScheme.onTertiary,
                                  totalSwitches: distancesFilters.length,
                                  labels: distancesFilters,
                                  animate: true,
                                  animationDuration: 200,
                                  fontSize: 12,
                                  onToggle: (index) {
                                    distanceFiltersSwitchIndex.value =
                                        index ?? 0;
                                    print('switched to: $index');
                                  },
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                            '${priceFilterStartValue.value == 0 && priceFilterEndValue.value == pricesFilters.length - 1 ? 'Any price' : '${pricesFilters[priceFilterStartValue.value]} ${priceFilterEndValue.value == priceFilterStartValue.value ? '' : '- ${pricesFilters[priceFilterEndValue.value]}'}'} '),
                                      ),
                                    ),
                                    Expanded(
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackShape:
                                              const RectangularSliderTrackShape(),
                                          trackHeight: 6.0,
                                          valueIndicatorShape:
                                              const RoundSliderOverlayShape(),
                                          rangeThumbShape:
                                              const RoundRangeSliderThumbShape(
                                                  enabledThumbRadius: 16),
                                          rangeValueIndicatorShape:
                                              const PaddleRangeSliderValueIndicatorShape(),
                                        ),
                                        child: RangeSlider(
                                          activeColor: context.theme.colorScheme
                                              .primaryContainer,
                                          inactiveColor: context
                                              .theme.colorScheme.tertiary,
                                          onChanged: (RangeValues values) {
                                            priceFilterStartValue.value =
                                                values.start.toInt();
                                            priceFilterEndValue.value =
                                                values.end.toInt();
                                          },
                                          max: pricesFilters.length - 1,
                                          divisions: pricesFilters.length - 1,
                                          values: RangeValues(
                                            priceFilterStartValue.value
                                                .toDouble(),
                                            priceFilterEndValue.value
                                                .toDouble(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
              ),
            ],
            const SliverGap(height: 12),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12)
                  .copyWith(bottom: 112),
              sliver: MultiSliver(
                children: [
                  if (resultState.value == 0) ...[
                    SliverToBoxAdapter(
                      child: CardContainer(
                        borderRadius: BorderRadius.circular(16),
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          direction: Axis.horizontal,
                          clipBehavior: Clip.hardEdge,
                          spacing: 6,
                          runSpacing: 18,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: List.generate(
                            randomWords.length,
                            (index) => Material(
                              borderRadius: BorderRadius.circular(8),
                              color: context.theme.colorScheme.tertiary,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                splashColor:
                                    context.theme.colorScheme.tertiaryContainer,
                                onTap: () {
                                  textEditingController.text =
                                      randomWords[index];
                                  resultState.value = 1;
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    randomWords[index],
                                    style: context.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                  if (resultState.value == 1) ...[
                    SliverList.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
