import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:recive/features/near_me_page/near_me_detail_screen.dart';
import 'package:recive/router/extra_data.dart';

extension StringLimit on String? {
  String dynamicSub(int limit) =>
      '${(this ?? '').length > 20 ? this!.substring(0, 20) : this ?? ''}...';
}

class FeaturedEventDetailScreen extends HookWidget {
  static const name = 'featured_event_detail';
  static const pathParamId = 'id';

  const FeaturedEventDetailScreen({
    super.key,
    required this.id,
    required this.extra,
  });

  final String id;
  final ExtraData<FeaturedEventDetailSummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final heroTag = extra?.heroTag ?? DateTime.now();
    final summary = extra?.summary == null
        ? null
        : NearbyDetailSummaryData(
            id: extra!.summary!.id,
            title: extra!.summary!.title,
            imageUrl: extra!.summary!.imageUrl,
          );

    return NearbyDetailScreen(
      id: id,
      extra: ExtraData(summary: summary, heroTag: heroTag.toString()),
    );
  }
}
