import 'package:flutter/material.dart';

import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/colored_network_image.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/widgets/arts_preview_grid.dart';
import 'package:recive/modules/home_page/widgets/see_more_button.dart';
import 'package:recive/modules/search_page/search_screen.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/string_extensions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/router/extra_data.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/utils/hooks.dart';

class CategoryDetailScreen extends StatefulHook {
  static const name = 'category_detail';
  static const pathParamId = 'category_id';
  const CategoryDetailScreen({
    super.key,
    required this.id,
    this.extra,
  });

  final String id;
  final ExtraData<CategorySummaryData>? extra;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final navigationService = locator.get<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<CategoriesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadCategory(widget.id);
      return () => bloc.emptyCategory();
    }, effectRunOnce);

    final data = state.category;
    final summary = widget.extra?.summary;
    final title = summary?.title ?? data?.title ?? '';
    final isImageLoading = summary == null && data == null;
    final isDataLoading = state.categoryLoadingState == LoadingState.loading || data == null;
    final infoStyle = context.textTheme.bodyMedium.onSecondaryContainer.style;

    return ColoredBox(
      color: context.colorTheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(title: title.dynamicSub(20)),
          SliverPadding(
            padding: kMediumPadding.copyWith(bottom: context.footerHeight + 32),
            sliver: MultiSliver(
              children: [
                SliverLoadingCheck(
                  loadingState: null,
                  isLoading: isImageLoading,
                  child: SliverCardContainer(
                    borderRadius: kMediumBorderRadius,
                    padding: kTinyPadding,
                    sliver: SliverToBoxAdapter(
                      child: Hero(
                        tag: widget.extra?.heroTag ?? widget.id,
                        child: ColoredNetworkImage(
                          imageUrl: summary?.imageUrl ?? data!.imageUrl,
                          constraints: const BoxConstraints.expand(height: 240),
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                SliverLoadingCheck(
                  loadingState: null,
                  isLoading: isDataLoading,
                  child: MultiSliver(
                    children: [
                      SliverCardContainer(
                        borderRadius: kMediumBorderRadius,
                        padding: kTinyPadding,
                        color: context.colorTheme.background,
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            data!.title,
                            textAlign: TextAlign.center,
                            style: infoStyle.copyWith(
                              fontSize: context.textTheme.titleTiny.style.fontSize,
                              color: context.colorTheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                      const SliverGap(height: 12),
                      SliverCardContainer(
                        borderRadius: kMediumBorderRadius,
                        padding: kTinyPadding,
                        color: context.colorTheme.secondary,
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.subtitle,
                                textAlign: TextAlign.center,
                                style: infoStyle.withColor(
                                  context.colorTheme.onSecondary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                data.description,
                                textAlign: TextAlign.center,
                                style: infoStyle.withColor(context.colorTheme.onSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverGap(height: 12),
                      if (state.items.isNotEmpty)
                        SliverCardContainer(
                          borderRadius: kMediumBorderRadius,
                          padding: kTinyPadding.copyWith(right: 0, bottom: 0),
                          color: context.colorTheme.secondary,
                          sliver: ArtsPreviewGrid(items: state.items),
                        ),
                      const SliverGap(height: 12),
                      SeeMoreButton(
                        color: context.colorTheme.secondary,
                        text: "Routes contains these items",
                        constraints: const BoxConstraints.expand(height: 54),
                        onTap: () => navigationService.moveTo(
                          SearchScreen.name,
                          queryParameters: {SearchScreen.keywordQueryKey: title},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
