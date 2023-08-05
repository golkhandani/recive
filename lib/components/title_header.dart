import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';

class TitleHeader extends HookWidget {
  const TitleHeader({
    super.key,
    this.title = '',
    this.backgroundColor = Colors.black,
  });
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final hightlightColor = context.schema.tertiary;
    return Container(
      padding: const EdgeInsets.all(8),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(kRadius),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kRadius),
                child: InkWell(
                  borderRadius: BorderRadius.circular(kRadius),
                  hoverColor: hightlightColor,
                  splashColor: hightlightColor,
                  highlightColor: hightlightColor,
                  enableFeedback: true,
                  onTap: () {
                    navigationService.backTo();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.schema.secondaryContainer.withOpacity(1),
                      backgroundBlendMode: BlendMode.hardLight,
                    ),
                    child: Iconify(
                      Mdi.arrow_back,
                      color: context.schema.onSecondaryContainer,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (title.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    title,
                    style: context.textTheme.titleSmall?.withColor(
                      context.schema.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 54),
        ],
      ),
    );
  }
}
