import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/models/recive.model.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CategoriesScreen extends HookWidget {
  static const name = 'categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'Categories',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: context.footerHeight + 16),
            sliver: MultiSliver(
              children: [
                SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CardContainer(
                          borderRadius: BorderRadius.circular(16),
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.theme.colorScheme.background,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpandablePanel(
                                    header: Text(
                                      "Article.title",
                                      style: context.textTheme.titleMedium,
                                    ),
                                    collapsed: Text(
                                      article,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    expanded: Text(
                                      article,
                                      softWrap: true,
                                    ),
                                    theme: ExpandableThemeData(
                                      iconSize: 20,
                                      iconPadding:
                                          const EdgeInsets.only(bottom: 12),
                                      iconColor: context
                                          .theme.colorScheme.onBackground,
                                      animationDuration:
                                          const Duration(milliseconds: 200),
                                      useInkWell: true,
                                      alignment: Alignment.topRight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
