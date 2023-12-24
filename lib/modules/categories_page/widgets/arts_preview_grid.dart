import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:recive/modules/categories_page/categories_screen.dart';
import 'package:recive/modules/categories_page/category_detail_screen.dart';
import 'package:recive/modules/featured_page/models/art_abstract_model.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container.dart';
import 'package:recive/modules/near_me_page/widgets/art_card_container_data.dart';
import 'package:recive/shared/constants/ui_constants.dart';

class ArtsPreviewGrid extends StatelessWidget {
  const ArtsPreviewGrid({
    super.key,
    required this.items,
  });

  final List<ArtAbstractModel> items;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: items.length,
        (context, index) {
          final data = ArtCardContainerData.fromAbstractArt(items[index]);
          return Padding(
            padding: EdgeInsets.only(
              bottom: kTinyPadding.bottom,
              right: kTinyPadding.right,
            ),
            child: ArtCardContainer(
              hero: CategoriesScreen.name + CategoryDetailScreen.name + data.id,
              constraints: const BoxConstraints.expand(),
              data: data,
            ),
          );
        },
      ),
      gridDelegate: SliverStairedGridDelegate(
        startCrossAxisDirectionReversed: true,
        pattern: const [
          StairedGridTile(1, 1.4),
          StairedGridTile(0.4, 0.5),
          StairedGridTile(0.6, 0.75),
          StairedGridTile(0.4, 0.5),
          StairedGridTile(0.6, 0.75),
          StairedGridTile(1, 1),
          // StairedGridTile(1, 6),
        ],
      ),
    );
  }
}
