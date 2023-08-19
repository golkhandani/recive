import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
// ignore: depend_on_referenced_packages

List<TopNewsCardContainerData> mockNews = [
  TopNewsCardContainerData(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4f',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features.',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  TopNewsCardContainerData(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1220a3f4d',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  TopNewsCardContainerData(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4d',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features.',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  TopNewsCardContainerData(
    id: '2e9b61d8-79a1-4f18-950f-bfd10003e7e2',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  TopNewsCardContainerData(
    id: '3c802d10-476b-42c0-8e1a-785f6c8210d4',
    title: 'New Study on Climate Change Impact',
    description:
        'A recent study reveals alarming effects of climate change on ocean temperatures.',
    publishDate: DateTime(2023, 8, 17, 12, 15),
    source: 'Environmental Watch',
  ),
  TopNewsCardContainerData(
    id: '4f671c11-01f2-4b09-9f92-eb27ebe4d65f',
    title: 'Space Exploration Milestone Achieved',
    description:
        'Astronauts successfully completed a record-breaking spacewalk mission.',
    publishDate: DateTime(2023, 8, 16, 9, 45),
    source: 'SpaceNews',
  ),
  TopNewsCardContainerData(
    id: '5a6f20d5-ff77-4e66-aa3c-723a9486c995',
    title: 'Local Community Celebrates Annual Festival',
    description:
        'Residents gather for a festive celebration showcasing cultural heritage.',
    publishDate: DateTime(2023, 8, 15, 17, 0),
    source: 'Community Gazette',
  ),
  // Add more news summaries here...
];

class HomePageTopNewsSections extends HookWidget {
  const HomePageTopNewsSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Top News Stories",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: LayoutBuilder(builder: (context, box) {
              return SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mockNews.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => index == mockNews.length
                      ? SeeMoreButton(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 2,
                          ),
                          onTap: () =>
                              navigationService.navigateTo(NewsScreen.name),
                        )
                      : TopNewsCardContainer(
                          constraints: BoxConstraints.expand(
                            width: box.maxWidth / 1.4,
                          ),
                          data: mockNews[index],
                        ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

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
    final color = Color((Random().nextDouble() * 0xFFFF).toInt())
        .withOpacity(1.0)
        .withAlpha(255);
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

    return InkWell(
      onTap: () => navigationService.navigateTo(
        DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.news.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.news.name + data.id,
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
          padding: const EdgeInsets.all(12),
          child: child,
        ),
      ),
    );
  }
}
