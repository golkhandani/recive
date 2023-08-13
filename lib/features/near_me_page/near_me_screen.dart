import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PageViewKeepAlive extends StatefulWidget {
  const PageViewKeepAlive({super.key, required this.data});

  final String data;

  @override
  State<PageViewKeepAlive> createState() => _PageViewKeepAliveState();
}

class _PageViewKeepAliveState extends State<PageViewKeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(widget.data);
  }
}

class NearMeScreen extends HookWidget {
  static const name = 'near_me';
  const NearMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final switchIndex = useState(0);
    final pageController = usePageController(initialPage: switchIndex.value);
    final switchItems = ['Map', 'List'];
    const switchDuration = Duration(milliseconds: 300);

    return ColoredBox(
      color: Colors.amber[100]!,
      child: LayoutBuilder(builder: (context, box) {
        final contentHeight = box.maxHeight - context.invisibleHeight - 24 - 32;
        final mapSectionHeight = (contentHeight * 0.65) - 24 - 12;
        final listSectionHeight = (contentHeight * 0.35) - 24 - 12;
        return CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            ScreenSafeAreaHeader(
              color: context.theme.primaryColor,
              title: 'Near me!',
            ),
            const SliverGap(height: 12),
            SliverLayoutBuilder(builder: (context, sliver) {
              return SliverToBoxAdapter(
                child: Center(
                  child: ToggleSwitch(
                    minWidth: sliver.crossAxisExtent / 4,
                    minHeight: 42.0,
                    fontSize: 16.0,
                    initialLabelIndex: switchIndex.value,
                    activeBgColor: [context.theme.colorScheme.primaryContainer],
                    activeFgColor: context.theme.colorScheme.onPrimaryContainer,
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
                ),
              );
            }),
            const SliverGap(height: 12),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.transparent,
                height: contentHeight + 100,
                width: box.maxWidth,
                child: PageView(
                  allowImplicitScrolling: false,
                  controller: pageController,
                  onPageChanged: (value) => switchIndex.value = value,
                  children: [
                    CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      slivers: [
                        _NearMeScreenMapViewContent(
                          switchIndex: switchIndex,
                          switchItems: switchItems,
                          mapSectionHeight: mapSectionHeight,
                          listSectionHeight: listSectionHeight,
                        ),
                      ],
                    ),
                    const CustomScrollView(
                      slivers: [
                        _NearMeScreenListViewContent(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _NearMeScreenListViewContent extends StatelessWidget {
  const _NearMeScreenListViewContent();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 112),
      sliver: SliverList.builder(
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
    );
  }
}

class _NearMeScreenMapViewContent extends StatelessWidget {
  const _NearMeScreenMapViewContent({
    required this.switchIndex,
    required this.switchItems,
    required this.mapSectionHeight,
    required this.listSectionHeight,
  });

  final ValueNotifier<int> switchIndex;
  final List<String> switchItems;
  final double mapSectionHeight;
  final double listSectionHeight;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: MultiSliver(
        children: [
          MultiSliver(children: [
            SliverCardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(12),
              sliver: SliverLayoutBuilder(builder: (context, sliver) {
                return SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    width: sliver.crossAxisExtent,
                    height: mapSectionHeight,
                  ),
                );
              }),
            )
          ]),
          const SliverGap(height: 12),
          MultiSliver(
            children: [
              SliverCardContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(12),
                sliver: SliverLayoutBuilder(builder: (context, sliver) {
                  return SliverToBoxAdapter(
                    child: FlutterCarousel.builder(
                      options: CarouselOptions(
                        autoPlay: false,
                        disableCenter: true,
                        viewportFraction: .9,
                        height: listSectionHeight,
                        indicatorMargin: 12.0,
                        enableInfiniteScroll: true,
                        padEnds: true,
                        slideIndicator: const CircularSlideIndicator(),
                      ),
                      itemCount: 10 + 1,
                      itemBuilder: (context, i, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: index == 10 + 1
                            ? Container(
                                width: sliver.asBoxConstraints().maxWidth / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.theme.colorScheme.secondary,
                                ),
                                child: Center(
                                  child: Text(
                                    "See More!",
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      color: context.theme.colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: sliver.asBoxConstraints().maxWidth / 1.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueAccent,
                                ),
                              ),
                      ),
                    ),
                  );
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: listSectionHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 11,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) => index == 10
                            ? Container(
                                width: sliver.asBoxConstraints().maxWidth / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.theme.colorScheme.secondary,
                                ),
                                child: Center(
                                  child: Text(
                                    "See More!",
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      color: context.theme.colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: sliver.asBoxConstraints().maxWidth / 1.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blueAccent,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SliverGap(height: 32),
        ],
      ),
    );
  }
}
