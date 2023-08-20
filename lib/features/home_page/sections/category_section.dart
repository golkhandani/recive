import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/categories_page/categories_screen.dart';
import 'package:recive/features/categories_page/cubits/category_section_cubit.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
              padding: const EdgeInsets.all(12),
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
                              onTap: () => navigationService.navigateTo(
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

class CategoryCardContainerData {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  CategoryCardContainerData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
  });

  static CategoryCardContainerData fromCategory(Category c) =>
      CategoryCardContainerData(
        id: c.id,
        title: c.title,
        subtitle: c.subtitle,
        description: c.description,
        imageUrl: c.imageUrl,
      );
}

class CategoryCardContainer extends HookWidget {
  const CategoryCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final CategoryCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = Color((Random().nextDouble() * 0xFFFF).toInt())
        .withOpacity(1.0)
        .withAlpha(255);
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleLarge!.copyWith(
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.textTheme.labelSmall!.copyWith(
            color: context.theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () => navigationService.navigateTo(
        DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.category.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.category.name + data.id,
        child: CachedNetworkImage(
          imageUrl: data.imageUrl,
          imageBuilder: (context, imageProvider) =>
              _buildCategoryCard(imageProvider, color, child),
          placeholder: (context, url) => _buildCategoryLoading(color),
          errorWidget: (context, url, error) =>
              _buildCategoryCard(null, color, child),
        ),
      ),
    );
  }

  Container _buildCategoryLoading(Color color) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container _buildCategoryCard(
    ImageProvider<Object>? imageProvider,
    Color color,
    Column child,
  ) {
    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        image: imageProvider == null
            ? null
            : DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            color.lighten(0.2),
            color.darken(),
          ],
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
