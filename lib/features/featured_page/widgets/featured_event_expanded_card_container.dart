import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/featured_page/featured_detail_screen.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/featured_page/widgets/featured_event_card_container.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class FeaturedEventExpandedCardContainer extends HookWidget {
  const FeaturedEventExpandedCardContainer({
    super.key,
    required this.data,
  });

  final FeaturedEventCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final extra = ExtraData(
      summary: FeaturedEventDetailSummaryData(
        id: data.id,
        title: data.title,
        imageUrl: data.imageUrl,
      ),
      heroTag: data.id,
    ).toJson((inner) => inner.toJson());
    return InkWell(
      onTap: () => navigationService.navigateTo(
        FeaturedScreen.name + FeaturedEventDetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
        },
        extra: extra,
      ),
      child: CardContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.background,
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
                    style: context.titleLargeOnBackground,
                  ),
                  collapsed: Row(
                    children: [
                      Iconify(
                        Bx.bxs_map,
                        color: context.colorScheme.onBackground,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          data.location,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: context.labelLargeOnBackground,
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
                          style: context.labelLargeOnBackground,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Iconify(
                              Bx.bxs_map,
                              color: context.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.location,
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: context.colorScheme.onBackground,
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
                              color: context.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.labelLargeOnBackground,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Iconify(
                              Bx.briefcase,
                              color: context.colorScheme.onBackground,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.organizers.join(' '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.labelLargeOnBackground,
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
                    iconColor: context.colorScheme.onBackground,
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
