import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/categories_page/widgets/category_card_container.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:recive/enums/loading_state.dart';

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
    final bloc = useBloc<CategoriesCubit>();
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
                "Event Categories",
                style: context.textTheme.headlineSmall,
              ),
            ),
            const SliverGap(height: 12),
            SliverCardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: kTinyPadding,
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 76,
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
