import 'package:flutter/material.dart';

import 'package:recive/features/near_me_page/widgets/map_button.dart';

class FlutterMapSearchRefreshButton extends StatelessWidget {
  const FlutterMapSearchRefreshButton({
    super.key,
    required this.isRefreshingData,
    required this.onRefreshDataClicked,
  });

  final bool isRefreshingData;
  final VoidCallback onRefreshDataClicked;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 12,
      child: MapButton(
        text: 'Search in this area!',
        icon: Icons.refresh,
        isLoading: isRefreshingData,
        onClicked: onRefreshDataClicked,
      ),
    );
  }
}
