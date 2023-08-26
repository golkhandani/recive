import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FeaturedScreen extends HookWidget {
  static const name = 'featured';
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<FeatureEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeaturedEvents();
      return;
    }, []);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'News',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: context.footerHeight + 16),
            sliver: Builder(builder: (context) {
              return context.checkLoadingState(state.loadingState) ??
                  MultiSliver(
                    children: [
                      SliverList.builder(
                        addAutomaticKeepAlives: true,
                        itemCount: state.featuredEvents.length,
                        itemBuilder: (context, index) {
                          final data =
                              FeaturedEventCardContainerData.fromFeaturedEvent(
                            state.featuredEvents[index],
                          );
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: FeaturedEventExpandedCardContainer(
                              data: data,
                            ),
                          );
                        },
                      ),
                    ],
                  );
            }),
          ),
        ],
      ),
    );
  }
}

class FeaturedEventExpandedCardContainer extends HookWidget {
  const FeaturedEventExpandedCardContainer({
    super.key,
    required this.data,
  });

  final FeaturedEventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    return InkWell(
      onTap: () => navigationService.navigateTo(
        FeaturedScreen.name + FeaturedEventDetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
        },
        extra: ExtraData(
          summary: data,
          heroTag: data.id,
        ).toJson(),
      ),
      child: CardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.theme.colorScheme.background,
          ),
          child: Column(
            children: [
              Hero(
                tag: data.id,
                child: CachedNetworkImage(
                  imageUrl: data.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        opacity: 0.9,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text(
                    data.title,
                    style: context.textTheme.titleLarge!.copyWith(
                      color: context.theme.colorScheme.onBackground,
                    ),
                  ),
                  collapsed: Row(
                    children: [
                      Iconify(
                        Bx.bxs_map,
                        color: context.theme.colorScheme.onBackground,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          data.location,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: context.textTheme.labelLarge!.copyWith(
                            color: context.theme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  expanded: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.description,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: context.textTheme.labelLarge!.copyWith(
                            color: context.theme.colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Iconify(
                              Bx.bxs_map,
                              color: context.theme.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.location,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: context.theme.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Iconify(
                              Bx.calendar_event,
                              color: context.theme.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: context.theme.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Iconify(
                              Bx.briefcase,
                              color: context.theme.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.organizers.join(' '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: context.theme.colorScheme.onBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  theme: ExpandableThemeData(
                    iconSize: 20,
                    iconPadding: const EdgeInsets.only(bottom: 12),
                    iconColor: context.theme.colorScheme.onBackground,
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
