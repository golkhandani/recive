import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/categories_page/categories_screen.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/widgets/category_card_container.dart';
import 'package:recive/modules/categories_page/widgets/category_card_container_data.dart';
import 'package:recive/modules/home_page/widgets/see_more_button.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/navigation_service.dart';

class HomePageCategoriesSection extends StatefulHookWidget {
  const HomePageCategoriesSection({
    super.key,
  });

  @override
  State<HomePageCategoriesSection> createState() =>
      _HomePageCategoriesSectionState();
}

class _HomePageCategoriesSectionState extends State<HomePageCategoriesSection> {
  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = context.read<CategoriesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadCategories();
      return;
    }, []);

    return context.checkLoadingState(state.loadingState) ??
        MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                "Art Categories",
                style: context.textTheme.headlineSmall?.withColor(
                  context.colorScheme.onBackground,
                ),
              ),
            ),
            const SliverGap(height: 12),
            SliverCardContainer(
              borderRadius: kMediumBorderRadius,
              padding: kTinyPadding,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 80,
                  child: LayoutBuilder(builder: (context, box) {
                    if (state.loadingState == LoadingState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categoriesSpotlight.length + 1,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          if (index == state.categoriesSpotlight.length) {
                            return SeeMoreButton(
                              constraints: BoxConstraints.expand(
                                width: box.maxWidth / 2,
                              ),
                              onTap: () => navigationService.pushTo(
                                CategoriesScreen.name,
                              ),
                            );
                          }
                          final data = CategoryCardContainerData.fromCategory(
                            state.categoriesSpotlight[index],
                          );
                          return CategoryCardContainer(
                            constraints: BoxConstraints.expand(
                              width: box.maxWidth / 2,
                            ),
                            data: data,
                          );
                        });
                  }),
                ),
              ),
            ),
          ],
        );
  }
}
