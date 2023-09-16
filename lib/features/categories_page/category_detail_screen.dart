import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/components/colored_network_image.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/color_extentions.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/featured_page/featured_screen.dart';
import 'package:recive/features/featured_page/widgets/featured_event_card_container.dart';
import 'package:recive/features/featured_page/widgets/featured_event_card_container_data.dart';
import 'package:recive/features/home_page/widgets/see_more_button.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:recive/router/navigation_service.dart';

class CategoryDetailScreen extends HookWidget {
  static const name = 'category_detail';
  static const pathParamId = 'id';
  const CategoryDetailScreen({
    super.key,
    required this.id,
    this.extra,
  });

  final String id;
  final ExtraData<CategorySummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<CategoriesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadCategory(id);
      return () => bloc.emptyCategory();
    }, []);

    final data = state.category;
    final summary = extra?.summary;

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            title: summary?.title ?? data?.title ?? '',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: Builder(builder: (context) {
              if (summary == null && data == null) {
                return kSliverFillLoading;
              }

              return MultiSliver(
                children: [
                  SliverCardContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: kTinyPadding,
                    sliver: SliverToBoxAdapter(
                      child: Hero(
                        tag: extra?.heroTag ?? id,
                        child: ColoredNetworkImage(
                          imageUrl: summary?.imageUrl ?? data!.imageUrl,
                          constraints: const BoxConstraints.expand(height: 240),
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                  const SliverGap(height: 12),
                  Builder(builder: (context) {
                    if (state.categoryLoadingState == LoadingState.loading ||
                        data == null) {
                      return kSliverFillLoading;
                    }

                    final infoStyle = context.textTheme.bodyMedium!.copyWith(
                      color: context.theme.colorScheme.onPrimaryContainer,
                    );
                    return MultiSliver(
                      children: [
                        SliverCardContainer(
                          borderRadius: BorderRadius.circular(16),
                          padding: kTinyPadding,
                          color: context.colorScheme.background,
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              padding: kTinyPadding,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.colorScheme.background,
                              ),
                              child: Center(
                                child: Text(
                                  data.title,
                                  style: infoStyle.copyWith(
                                    fontSize:
                                        context.textTheme.titleLarge!.fontSize,
                                    color: context.colorScheme.onBackground,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SliverGap(height: 12),
                        SliverCardContainer(
                          borderRadius: BorderRadius.circular(16),
                          padding: kTinyPadding,
                          color: context.colorScheme.surface,
                          sliver: SliverToBoxAdapter(
                            child: Container(
                              padding: kTinyPadding,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.colorScheme.surface,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      data.subtitle,
                                      style: infoStyle.withColor(
                                        context.colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      data.description,
                                      style: infoStyle.withColor(
                                        context.colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SliverGap(height: 12),
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            childCount: state.items.length + 1,
                            (context, index) {
                              if (index == state.items.length) {
                                return SeeMoreButton(
                                  constraints: const BoxConstraints.expand(),
                                  onTap: () => navigationService
                                      .pushTo(FeaturedScreen.name),
                                );
                              }

                              final data = FeaturedArtCardContainerData
                                  .fromFeaturedEvent(
                                state.items[index],
                              );
                              return FeaturedArtCardContainer(
                                parentPathParams: const {},
                                parentRoute: CategoryDetailScreen.name,
                                constraints: const BoxConstraints.expand(),
                                data: data,
                              );
                            },
                          ),
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 5,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            repeatPattern: QuiltedGridRepeatPattern.same,
                            pattern: const [
                              QuiltedGridTile(4, 5),
                              QuiltedGridTile(5, 3),
                              QuiltedGridTile(5, 2),
                              QuiltedGridTile(3, 5),
                              QuiltedGridTile(5, 3),
                              QuiltedGridTile(5, 2),
                              QuiltedGridTile(3, 3),
                              QuiltedGridTile(3, 2),
                              QuiltedGridTile(5, 2),
                              QuiltedGridTile(4, 3),
                              QuiltedGridTile(1, 3),
                            ],
                          ),
                        ),
                        const SliverGap(height: 12),
                      ],
                    );
                  })
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
