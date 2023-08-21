import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/components/card_container.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:recive/features/near_me_page/sections/map_section.dart';

class NearMeScreenListViewContent extends HookWidget {
  const NearMeScreenListViewContent({
    super.key,
    required this.items,
  });
  final List<EventCardContainerData> items;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 112),
      sliver: SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CardContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(12),
                child: EventCardContainer(
                  constraints: const BoxConstraints.expand(height: 200),
                  data: items[index],
                ),
              ),
            );
          }),
    );
  }
}
