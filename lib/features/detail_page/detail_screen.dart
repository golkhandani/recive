import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum DetailType {
  news,
  event,
  place,
  category,
  unknown,
  ;

  static DetailType fromString(String str) {
    switch (str) {
      case 'news':
        return DetailType.news;
      case 'event':
        return DetailType.event;
      case 'place':
        return DetailType.place;
      case 'category':
        return DetailType.category;
      default:
        return DetailType.unknown;
    }
  }
}

class DetailScreen extends HookWidget {
  static const name = 'detail';
  static const pathParamId = 'id';
  static const pathParamType = 'type';
  const DetailScreen({
    super.key,
    required this.id,
    required this.type,
    this.extraData,
  });

  final String id;
  final DetailType type;
  final ExtraData? extraData;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.surface,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            title: '${type.name.toCapitalized()} detail',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: MultiSliver(children: [
              SliverCardContainer(
                borderRadius: BorderRadius.circular(16),
                padding: kTinyPadding,
                sliver: SliverToBoxAdapter(
                  child: Hero(
                    tag: DetailScreen.name + type.name + id,
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey,
                      ),
                      child: const Center(child: Text('IMAGE')),
                    ),
                  ),
                ),
              ),
              const SliverGap(height: 12),
              if (type == DetailType.category) ...[
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueAccent,
                      ),
                      child: const Center(child: Text('CATEGORY TEXT')),
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                      ),
                      child: const Center(child: Text('VIEW EVENTS')),
                    ),
                  ),
                ),
              ] else ...[
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orangeAccent,
                      ),
                      child: const Center(child: Text('DATE, ADDRESS')),
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                if (type != DetailType.news) ...[
                  SliverCardContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: kTinyPadding,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.redAccent,
                        ),
                        child: const Center(child: Text('RATING')),
                      ),
                    ),
                  ),
                  const SliverGap(height: 12),
                ],
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('TEXT')),
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                if (type != DetailType.news) ...[
                  SliverCardContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: kTinyPadding,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amber,
                        ),
                        child: const Center(child: Text('MAP')),
                      ),
                    ),
                  )
                ],
              ],
            ]),
          ),
        ],
      ),
    );
  }
}
