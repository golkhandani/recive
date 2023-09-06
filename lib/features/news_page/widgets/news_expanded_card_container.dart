import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/features/news_page/news_detail_screen.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/features/news_page/widgets/news_card_container.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class TopNewsExpandedCardContainer extends HookWidget {
  const TopNewsExpandedCardContainer({
    super.key,
    required this.data,
  });

  final TopNewsCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final style = context.textTheme.headlineSmall!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    final color = context.colorScheme.surface;
    final fontColor = context.colorScheme.onSurface;

    final heroTag = NewsDetailScreen.name + data.id;

    final rotateTitles = [
      RotateAnimatedText(
        data.source,
        textStyle: style,
        textAlign: TextAlign.center,
      ),
      RotateAnimatedText(
        data.title,
        textStyle: style,
        textAlign: TextAlign.center,
      ),
      RotateAnimatedText(
        DateFormat.MMMd().format(data.publishDate),
        textStyle: style,
        textAlign: TextAlign.center,
      ),
    ]..shuffle();
    final extra = ExtraData(
      summary: NewsSummaryData(id: data.id, title: data.title),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
    final colorDynamic =
        TopNewsCardContainerData.sourceToColorMap[data.source]?.darken(.3) ??
            context.randomColor;
    return Hero(
      tag: heroTag,
      child: CardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: kTinyPadding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => navigationService.pushTo(
                  NewsScreen.name + NewsDetailScreen.name,
                  pathParameters: {
                    NewsDetailScreen.pathParamId: data.id,
                  },
                  extra: extra,
                ),
                child: Container(
                  height: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorDynamic,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AbsorbPointer(
                        child: AnimatedTextKit(
                          animatedTexts: rotateTitles,
                          pause: const Duration(milliseconds: 300),
                          displayFullTextOnTap: false,
                          stopPauseOnTap: false,
                          repeatForever: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text(
                    data.title,
                    style: context.titleLargeOnBackground.withColor(fontColor),
                  ),
                  collapsed: Column(
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Iconify(
                            Bx.calendar_event,
                            color: fontColor,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat.MMMd().format(data.publishDate),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelSmall!.copyWith(
                              color: fontColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Iconify(
                            Mdi.volume_source,
                            color: fontColor,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              data.source,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall!.copyWith(
                                color: fontColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                  expanded: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Iconify(
                              Bx.calendar_event,
                              color: fontColor,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat.MMMd().format(data.publishDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall!.copyWith(
                                color: fontColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Iconify(
                              Mdi.volume_source,
                              color: fontColor,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.source,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall!.copyWith(
                                  color: fontColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          data.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  theme: ExpandableThemeData(
                    iconSize: 20,
                    iconPadding: const EdgeInsets.only(bottom: 12),
                    iconColor: fontColor,
                    animationDuration: const Duration(milliseconds: 200),
                    useInkWell: true,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
