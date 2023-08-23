import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomePageFeaturedEventsSection extends HookWidget {
  const HomePageFeaturedEventsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<FeatureEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeaturedEvents();
      return;
    }, []);

    return context.checkLoadingState(state.loadingState) ??
        MultiSliver(
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
              sliver: Builder(
                builder: (context) {
                  if (state.loadingState == LoadingState.loading) {
                    return const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 600,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return MultiSliver(
                    children: [
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.featuredEventsSpotlight.length +
                                1, (context, index) {
                          if (index == state.featuredEventsSpotlight.length) {
                            return SeeMoreButton(
                              constraints: const BoxConstraints.expand(),
                              onTap: () => navigationService
                                  .navigateTo(FeaturedScreen.name),
                            );
                          }

                          final data =
                              FeaturedEventCardContainerData.fromFeaturedEvent(
                            state.featuredEventsSpotlight[index],
                          );
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
                  );
                },
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

  static FeaturedEventCardContainerData fromFeaturedEvent(FeaturedEvent e) {
    return FeaturedEventCardContainerData(
      id: e.id,
      title: e.title,
      description: e.description,
      startDate: e.startDate,
      endDate: e.endDate,
      location: e.location,
      organizers: e.organizers,
      participants: e.participants,
      imageUrl: e.imageUrl,
    );
  }
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
    final color =
        context.theme.colorScheme.primaryContainer ?? context.randomColor;

    final child = LayoutBuilder(builder: (context, box) {
      final isSmall = MediaQuery.sizeOf(context).width / 2 > box.maxWidth;
      final isSmallTall = box.maxWidth < 160;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            maxLines: isSmallTall ? 3 : 1,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            maxLines: isSmallTall ? 3 : 1,
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
                  maxLines: isSmallTall ? 3 : 1,
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
        HomeScreen.name + FeaturedEventDetailScreen.name,
        pathParameters: {
          FeaturedEventDetailScreen.pathParamId: data.id,
        },
        extra: data,
      ),
      child: Hero(
        tag: FeaturedEventDetailScreen.name + data.id,
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
