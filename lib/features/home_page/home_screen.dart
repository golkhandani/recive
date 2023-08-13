import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/components/title_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends HookWidget {
  static const name = 'top_locations';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.amber[100]!,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'All you need!',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12).copyWith(bottom: 112),
            sliver: MultiSliver(
              children: [
                const SliverGap(height: 12),
                MultiSliver(
                  children: [
                    SliverToBoxAdapter(
                      child: Text(
                        "Event Categories",
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                    const SliverGap(height: 12),
                    SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverLayoutBuilder(builder: (context, sliver) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: 76,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 11,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) => index == 10
                                  ? Container(
                                      width:
                                          sliver.asBoxConstraints().maxWidth /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            context.theme.colorScheme.secondary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "See More!",
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: context.theme.colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width:
                                          sliver.asBoxConstraints().maxWidth /
                                              1.8,
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
                      padding: const EdgeInsets.all(12),
                      sliver: MultiSliver(
                        children: [
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: 4,
                              (context, index) => index == 3
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            context.theme.colorScheme.secondary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "See More!",
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: context.theme.colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.amber,
                                      ),
                                    ),
                            ),
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
                      ),
                    ),
                  ],
                ),
                const SliverGap(height: 32),
                MultiSliver(
                  children: [
                    SliverToBoxAdapter(
                      child: Text(
                        "Top News Stories",
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                    const SliverGap(height: 12),
                    SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverLayoutBuilder(builder: (context, sliver) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 11,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) => index == 10
                                  ? Container(
                                      width:
                                          sliver.asBoxConstraints().maxWidth /
                                              2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            context.theme.colorScheme.secondary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "See More!",
                                          style: context.textTheme.titleMedium!
                                              .copyWith(
                                            color: context.theme.colorScheme
                                                .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width:
                                          sliver.asBoxConstraints().maxWidth /
                                              1.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.teal,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ), // Weather Updates
                const SliverGap(height: 32),
                MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: Text(
                      "Today's weather",
                      style: context.textTheme.headlineSmall,
                    ),
                  ),
                  const SliverGap(height: 12),
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
                          width: sliver.asBoxConstraints().maxWidth,
                          height: sliver.asBoxConstraints().maxWidth,
                        ),
                      );
                    }),
                  )
                ]),
                const SliverGap(height: 32),
                MultiSliver(children: [
                  SliverToBoxAdapter(
                    child: Text(
                      "City Highlights (Map)",
                      style: context.textTheme.headlineSmall,
                    ),
                  ),
                  const SliverGap(height: 12),
                  SliverCardContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.all(12),
                    sliver: SliverLayoutBuilder(builder: (context, sliver) {
                      return SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                          ),
                          width: sliver.asBoxConstraints().maxWidth,
                          height: sliver.asBoxConstraints().maxWidth,
                        ),
                      );
                    }),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliverCardContainer extends StatelessWidget {
  const SliverCardContainer(
      {super.key,
      required this.sliver,
      this.padding = const EdgeInsets.all(24),
      this.color = Colors.white,
      this.borderRadius = BorderRadius.zero});

  final Widget sliver;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      insetOnOverlap: false, // defaults to false
      children: <Widget>[
        SliverPositioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(.2, .2),
                  blurRadius: 2,
                  color: Colors.black26,
                )
              ],
              borderRadius: borderRadius,
            ),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: sliver,
        )
      ],
    );
  }
}

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color = Colors.white,
    this.borderRadius = BorderRadius.zero,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(.2, .2),
                  blurRadius: 2,
                  color: Colors.black26,
                )
              ],
              borderRadius: borderRadius,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: child,
        )
      ],
    );
  }
}

class ScreenSafeAreaHeader extends StatelessWidget {
  const ScreenSafeAreaHeader({
    super.key,
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        height: context.viewTopPaddingHeight + context.headerHeight,
        color: color,
        child: Padding(
          padding: context.viewTopPadding,
          child: TitleHeader(
            title: title,
          ),
        ),
      ),
    );
  }
}
