import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';

import 'package:recive/layout/context_ui_extension.dart';

class FutterMapClusterLayer extends StatelessWidget {
  const FutterMapClusterLayer({
    super.key,
    required this.controller,
  });

  final SuperclusterMutableController? controller;

  @override
  Widget build(BuildContext context) {
    return SuperclusterLayer.mutable(
      initialMarkers: const [],
      controller: controller,
      loadingOverlayBuilder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      indexBuilder: IndexBuilders.rootIsolate,
      clusterWidgetSize: const Size(40, 40),
      maxClusterRadius: 40,
      minimumClusterSize: 2,
      anchor: AnchorPos.align(AnchorAlign.center),
      calculateAggregatedClusterData: true,
      builder: (context, position, markerCount, extraClusterData) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: context.colorScheme.errorContainer,
          ),
          child: Center(
            child: Text(
              markerCount.toString(),
              style: TextStyle(
                color: context.colorScheme.onErrorContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}
