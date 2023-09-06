import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/categories_page/widgets/category_card_container.dart';
import 'package:recive/features/categories_page/widgets/category_expanded_card_container.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CategoriesScreen extends HookWidget {
  static const name = 'categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<CategoriesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadCategories();
      return;
    }, []);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'Categories',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 16,
            ),
            sliver: Builder(builder: (context) {
              return context.checkLoadingState(state.loadingState) ??
                  MultiSliver(
                    children: [
                      SliverList.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final data = CategoryCardContainerData.fromCategory(
                              state.categories[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CategoryExpandedCardContainer(
                                data: data,
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
