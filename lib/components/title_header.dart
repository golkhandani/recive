import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/features/featured/greeting_header/bloc/greeting_header_bloc.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';

class TitleHeader extends HookWidget {
  const TitleHeader({
    super.key,
    this.title = '',
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    const hightlightColor = Colors.red;
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
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
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    backgroundBlendMode: BlendMode.hardLight,
                  ),
                  child: const Iconify(
                    Mdi.arrow_back,
                    color: Colors.white,
                    size: 36,
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
                    style: context.textTheme.titleSmall,
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
