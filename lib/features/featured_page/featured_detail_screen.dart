import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/featured_page/cubits/featured_events_cubit.dart';
import 'package:recive/features/home_page/sections/featured_event_section.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FeaturedEventDetailScreen extends HookWidget {
  static const name = 'featured_event_detail';
  static const pathParamId = 'id';
  const FeaturedEventDetailScreen({
    super.key,
    required this.id,
    this.summary,
  });

  final String id;
  final FeaturedEventCardContainerData? summary;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<FeatureEventsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadFeaturedEvent(id: id);
      return () => bloc.emptyFeaturedEvent();
    }, []);

    final summaryData = summary;

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title:
                '${summaryData?.title.substring(0, 20) ?? state.featuredEvent?.title ?? ''}...',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: context.footerHeight + 32),
            sliver: Builder(builder: (context) {
              const loading = SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              if (state.featuredEvent == null && summaryData == null) {
                return loading;
              }

              final data = state.featuredEvent;
              return MultiSliver(
                children: [
                  Builder(builder: (context) {
                    return SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverToBoxAdapter(
                        child: Hero(
                          tag: FeaturedEventDetailScreen.name + id,
                          child: CachedNetworkImage(
                            imageUrl: summaryData?.imageUrl ?? data!.imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 260,
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
                      ),
                    );
                  }),
                  Builder(builder: (context) {
                    if (data == null) {
                      return loading;
                    }
                    return SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.theme.colorScheme.secondary,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  data.title,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleLarge!.copyWith(
                                    color: context
                                        .theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Builder(builder: (context) {
                    if (data == null) {
                      return loading;
                    }
                    return SliverCardContainer(
                      borderRadius: BorderRadius.circular(16),
                      padding: const EdgeInsets.all(12),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.theme.colorScheme.primaryContainer,
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  data.description,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: context
                                        .theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Iconify(
                                    Bx.bxs_map,
                                    color: context.theme.colorScheme.background,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      data.location,
                                      overflow: TextOverflow.fade,
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        color: context.theme.colorScheme
                                            .onPrimaryContainer,
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
                                    color: context.theme.colorScheme.background,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${DateFormat.yMMMd().format(data.startDate)} - ${DateFormat.yMMMd().format(data.endDate)}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                        color: context.theme.colorScheme
                                            .onPrimaryContainer,
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
                                    color: context
                                        .theme.colorScheme.onPrimaryContainer,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      data.organizers.join(' '),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        color: context.theme.colorScheme
                                            .onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
