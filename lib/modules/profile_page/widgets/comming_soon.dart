import 'package:flutter/material.dart';

import 'package:recive/shared/extensions/text_style_extension.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "COMMING SOON!",
        style: context.textTheme.titleSmall.onCardBackground.style,
      ),
    );
  }
}
