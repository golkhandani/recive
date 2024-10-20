import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expandable/expandable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import 'package:recive/core/components/card_container.dart';
import 'package:recive/modules/news_page/news_detail_screen.dart';
import 'package:recive/modules/news_page/news_screen.dart';
import 'package:recive/modules/news_page/widgets/news_card_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';

class TopNewsExpandedCardContainer extends HookWidget {
  const TopNewsExpandedCardContainer({
    super.key,
    required this.data,
  });

  final TopNewsCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final style = context.textTheme.headerLarge
        .copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )
        .style;
    final color = context.colorTheme.surface;
    final fontColor = context.colorTheme.onSurface;

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
    return RepaintBoundary(
      child: Hero(
        tag: heroTag,
        child: CardContainer(
          borderRadius: kMediumBorderRadius,
          padding: kTinyPadding,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: kSmallBorderRadius,
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
                      borderRadius: kSmallBorderRadius,
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
                      style: context.textTheme.titleSmall
                          .withColor(fontColor)
                          .style,
                    ),
                    collapsed: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              FluentIcons.calendar_12_regular,
                              color: fontColor,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat.MMMd().format(data.publishDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.label
                                  .copyWith(
                                    color: fontColor,
                                  )
                                  .style,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              FluentIcons.sound_source_20_regular,
                              color: fontColor,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.source,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.label
                                    .copyWith(
                                      color: fontColor,
                                    )
                                    .style,
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
                              Icon(
                                FluentIcons.calendar_12_regular,
                                color: fontColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat.MMMd().format(data.publishDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.label
                                    .copyWith(
                                      color: fontColor,
                                    )
                                    .style,
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                FluentIcons.sound_source_20_regular,
                                color: fontColor,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  data.source,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.label
                                      .copyWith(
                                        color: fontColor,
                                      )
                                      .style,
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
                            style: context.textTheme.bodySmall
                                .copyWith(
                                  color: fontColor,
                                )
                                .style,
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
      ),
    );
  }
}
