import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

final List<String> images = [
  'https://source.unsplash.com/random/?nature,mountain',
  'https://source.unsplash.com/random/?architecture,skyscraper',
  'https://source.unsplash.com/random/?travel,beach',
  'https://source.unsplash.com/random/?food,pizza',
  'https://source.unsplash.com/random/?fashion,style',
  'https://source.unsplash.com/random/?art,sculpture',
  'https://source.unsplash.com/random/?sports,athlete',
  'https://source.unsplash.com/random/?music,concert',
  'https://source.unsplash.com/random/?animal,wildlife',
  'https://source.unsplash.com/random/?vehicle,car',
  // Add more image URLs here...
];
List<FeaturedEventCardContainerData> mockFeaturedEventsData = [
  FeaturedEventCardContainerData(
    id: 'c7e4db9e-9377-4e52-9b26-3b03d2fb4d81',
    title: 'Tech Conference',
    description: 'An event showcasing the latest technology trends.',
    startDate: DateTime(2023, 9, 15, 9, 0),
    endDate: DateTime(2023, 9, 17, 18, 0),
    location: 'City Convention Center',
    organizers: ['John Doe', 'Jane Smith'],
    participants: ['Alice Johnson', 'Bob Williams', 'Charlie Brown'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEventCardContainerData(
    id: '0d6d8c3e-6f61-4c9a-9a79-1d7eb77aa2ec',
    title: 'Art Exhibition',
    description: 'A gallery showcasing various forms of art.',
    startDate: DateTime(2023, 10, 5, 10, 0),
    endDate: DateTime(2023, 10, 8, 20, 0),
    location: 'Modern Art Gallery',
    organizers: ['Emily Davis', 'Michael Lee'],
    participants: ['Grace Turner', 'David Miller', 'Ella White'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEventCardContainerData(
    id: 'b72e0c4b-82d2-4e90-9e68-2656cc7b1c1c',
    title: 'Food Festival',
    description: 'A celebration of diverse culinary delights.',
    startDate: DateTime(2023, 11, 20, 12, 0),
    endDate: DateTime(2023, 11, 22, 22, 0),
    location: 'Central Park',
    organizers: ['Sarah Johnson', 'Robert Wilson'],
    participants: ['Olivia Harris', 'James Anderson', 'Sophia Martinez'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEventCardContainerData(
    id: 'f7a15f98-8904-42fc-82b2-76a6b53ec9f1',
    title: 'Workshop: Photography Basics',
    description: 'Learn the fundamentals of photography.',
    startDate: DateTime(2023, 9, 8, 14, 0),
    endDate: DateTime(2023, 9, 8, 18, 0),
    location: 'Community Center',
    organizers: ['Alice Brown'],
    participants: ['William Turner', 'Lily Adams'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
  FeaturedEventCardContainerData(
    id: 'de7549b6-6c91-4b0b-b81c-60b7e43a31d8',
    title: 'Charity Run',
    description: 'Run for a cause to support local charities.',
    startDate: DateTime(2023, 10, 12, 8, 0),
    endDate: DateTime(2023, 10, 12, 11, 0),
    location: 'City Park',
    organizers: ['Ryan Carter', 'Ava Robinson'],
    participants: ['Noah King', 'Sofia Johnson'],
    imageUrl: images[Random().nextInt(images.length)],
  ),
].take(3).toList();

class HomePageFeaturedEventsSection extends HookWidget {
  const HomePageFeaturedEventsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            "Featured Events",
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SliverGap(height: 12),
        SliverCardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          sliver: MultiSliver(
            children: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    childCount: mockFeaturedEventsData.length + 1,
                    (context, index) {
                  if (index == mockFeaturedEventsData.length) {
                    return SeeMoreButton(
                      constraints: const BoxConstraints.expand(),
                      onTap: () =>
                          navigationService.navigateTo(FeaturedScreen.name),
                    );
                  }

                  final data = mockFeaturedEventsData[index];
                  return FeaturedEventCardContainer(
                    constraints: const BoxConstraints.expand(),
                    data: data,
                  );
                }),
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  repeatPattern: QuiltedGridRepeatPattern.same,
                  pattern: const [
                    QuiltedGridTile(3, 4),
                    QuiltedGridTile(3, 2),
                    QuiltedGridTile(2, 2),
                    QuiltedGridTile(1, 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturedEventCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final List<String> organizers;
  final List<String> participants;
  final String imageUrl;

  FeaturedEventCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizers,
    required this.participants,
    required this.imageUrl,
  });
}

class FeaturedEventCardContainer extends HookWidget {
  const FeaturedEventCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final FeaturedEventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = Color((Random().nextDouble() * 0xFFFF).toInt())
        .withOpacity(1.0)
        .withAlpha(255);

    final child = LayoutBuilder(builder: (context, box) {
      print("Rwqe123ewqeqwrqw");
      print('sizes ${MediaQuery.sizeOf(context).width} - ${box.maxWidth}');
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < 160;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            maxLines: isSmallTall ? 1 : 3,
            overflow: TextOverflow.fade,
            style: context.textTheme.labelLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Iconify(
                Bx.bxs_map,
                color: color.lighten(0.7),
                size: 24,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  data.location,
                  maxLines: isSmallTall ? 1 : 3,
                  overflow: TextOverflow.fade,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isSmallTall) ...[
            Row(
              children: [
                Iconify(
                  Bx.calendar_event,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (!isSmall && !isSmallTall) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Iconify(
                  Bx.briefcase,
                  color: color.lighten(0.7),
                  size: 24,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    data.organizers.join(' '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    });
    return InkWell(
      onTap: () => navigationService.navigateTo(
        DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.event.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.event.name + data.id,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildEventCard(imageProvider, color, child),
          placeholder: (context, url) => _buildEventLoading(color),
          errorWidget: (context, url, error) =>
              _buildEventCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildEventLoading(Color color) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildEventCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Widget child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.1),
            color.darken(0.3),
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
