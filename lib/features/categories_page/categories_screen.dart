import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/home_page/sections/category_section.dart';
import 'package:recive/layout/context_ui_extension.dart';
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
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'Categories',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: context.footerHeight + 16),
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

class CategoryExpandedCardContainer extends StatelessWidget {
  const CategoryExpandedCardContainer({
    super.key,
    required this.data,
  });
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.colorScheme.background,
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: data.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandablePanel(
                header: Text(
                  data.title,
                  style: context.textTheme.titleMedium,
                ),
                collapsed: Text(
                  data.subtitle,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium,
                ),
                expanded: Text(
                  data.description,
                  softWrap: true,
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
    );
  }
}
