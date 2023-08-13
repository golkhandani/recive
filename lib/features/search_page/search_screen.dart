import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:recive/archived/featured_page/quick_search_header/quick_search_header_component.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/sliver_header_delegate.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SearchScreen extends HookWidget {
  static const name = 'search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resultState = useState(0);
    final textEditingController = useTextEditingController();

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

    return ColoredBox(
      color: Colors.amber[100]!,
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
              child: PinnedSearchHeader(
                padding: const EdgeInsets.all(12).copyWith(top: 0),
                height: 56,
                onSelect: (text) => resultState.value = 1,
                onTextChanged: (text) =>
                    text.isNotEmpty ? null : resultState.value = 0,
                textController: textEditingController,
              ),
            ),
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
