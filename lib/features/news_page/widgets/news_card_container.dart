import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/news_page/models/news_model.dart';
import 'package:recive/features/news_page/news_detail_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class TopNewsCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime publishDate;
  final String source;

  TopNewsCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.source,
  });

  static TopNewsCardContainerData fromNews(NewsModel n) =>
      TopNewsCardContainerData(
        id: n.id,
        title: n.title,
        description: n.description,
        publishDate: n.publishDate,
        source: n.source,
      );

  static Map<String, Color> sourceToColorMap = {
    'TechNews': Colors.red,
    'Science Times': Colors.greenAccent,
    'Environmental Watch': Colors.lightBlue,
    'SpaceNews': Colors.blue,
    'Community Gazette': Colors.pink
  };
}

class TopNewsCardContainer extends HookWidget {
  const TopNewsCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final TopNewsCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color =
        TopNewsCardContainerData.sourceToColorMap[data.source]?.darken(.3) ??
            context.randomColor;
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Iconify(
              Bx.calendar_event,
              color: color.lighten(0.7),
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat.MMMd().format(data.publishDate),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Iconify(
              Mdi.volume_source,
              color: color.lighten(0.7),
              size: 12,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                data.source,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.theme.colorScheme.onPrimaryContainer,
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
            color: context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
    final heroTag = NewsDetailScreen.name + data.id;
    final extra = ExtraData(
      summary: NewsSummaryData(id: data.id, title: data.title),
      heroTag: heroTag,
    ).toJson((inner) => inner.toJson());
    return InkWell(
      onTap: () => navigationService.navigateTo(
        HomeScreen.name + NewsDetailScreen.name,
        pathParameters: {
          NewsDetailScreen.pathParamId: data.id,
        },
        extra: extra,
      ),
      child: Hero(
        tag: heroTag,
        child: Container(
          constraints: constraints,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.darken(),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color,
                color.darken(),
              ],
            ),
          ),
          padding: kTinyPadding,
          child: child,
        ),
      ),
    );
  }
}
