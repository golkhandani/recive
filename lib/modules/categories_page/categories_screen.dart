import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/modules/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/modules/categories_page/widgets/category_card_container_data.dart';
import 'package:recive/modules/categories_page/widgets/category_expanded_card_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/utils/hooks.dart';

class CategoriesScreen extends StatefulHook {
  static const name = 'categories';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CategoriesCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadCategories();
      return;
    }, effectRunOnce);

    return ColoredBox(
      color: context.colorTheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(title: 'Categories'),
          SliverPadding(
            padding: kMediumPadding.copyWith(bottom: context.footerHeight + 16),
            sliver: SliverLoadingCheck(
              loadingState: state.loadingState,
              child: MultiSliver(
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
