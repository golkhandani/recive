import 'package:flutter/material.dart';

import 'package:recive/modules/package_page/models/art_route_model.dart';
import 'package:recive/modules/package_page/widgets/art_route_card_container_data.dart';
import 'package:recive/modules/package_page/widgets/art_route_expanded_card_container.dart';

class SearchResultAnimatedList extends StatelessWidget {
  const SearchResultAnimatedList({
    super.key,
    required this.listKey,
    required this.initialItem,
  });

  final GlobalKey<SliverAnimatedListState> listKey;
  final List<ArtRouteAbstractModel> initialItem;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: listKey,
      itemBuilder: (context, index, animation) {
        // Note: handle pre-view scroll items
        if (index > initialItem.length - 1) {
          return const SizedBox();
        }
        final data = ArtRouteContainerData.fromAbstract(
          initialItem[index],
        );
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ArtRouteExpandedCardContainer(
            data: data,
          ),
        );
      },
    );
  }
}
