import 'package:flutter/material.dart';

import 'package:recive/modules/near_me_page/widgets/map_button.dart';

class FlutterMapSearchRefreshController extends ValueNotifier<bool> {
  FlutterMapSearchRefreshController() : super(false);

  void updateValue(bool newValue) {
    value = newValue;
  }
}

class FlutterMapSearchRefreshButton extends StatelessWidget {
  const FlutterMapSearchRefreshButton({
    super.key,
    required this.refreshController,
    required this.onRefreshDataClicked,
  });

  final FlutterMapSearchRefreshController refreshController;
  final VoidCallback onRefreshDataClicked;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 12,
      child: ValueListenableBuilder(
        valueListenable: refreshController,
        builder: (context, value, child) {
          return MapButton(
            text: 'Search in this area!',
            icon: Icons.refresh,
            isLoading: value,
            onClicked: onRefreshDataClicked,
          );
        },
      ),
    );
  }
}
