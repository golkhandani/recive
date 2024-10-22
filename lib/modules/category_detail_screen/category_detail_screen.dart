import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/router/extra_data.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_bloc.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/dashboard_home_screen/widgets/art_card_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailScreen extends StatefulWidget {
  static String name = 'category-detail-screen';
  static String pathParamId = 'id';

  final String id;
  final ExtraData<CategoryCardContainerData>? extra;

  const CategoryDetailScreen({super.key, required this.id, this.extra});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final _bloc = locator.get<CategoryDetailBloc>();

  @override
  void initState() {
    _bloc.init(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<CategoryDetailBloc, CategoryDetailBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.isLoading == LoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.category == null) {
            return const SizedBox();
          }

          final category = state.category!;
          final arts = state.arts ?? [];

          return CustomScrollView(
            slivers: [
              CategoryDetailHeader(category: category),
              SliverPadding(
                padding: kMediumPadding,
                sliver: SliverList.separated(
                  itemCount: arts.length,
                  itemBuilder: (context, i) => ArtCardContainer.small(
                    data: ArtCardContainerData.fromAbstractArt(arts[i]),
                    constraints: const BoxConstraints.expand(height: 120),
                    onTap: () {},
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: kMediumPadding.bottom),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CategoryDetailHeader extends StatefulWidget {
  const CategoryDetailHeader({
    super.key,
    required this.category,
  });

  final CategoryAbstractModel category;

  @override
  State<CategoryDetailHeader> createState() => _CategoryDetailHeaderState();
}

class _CategoryDetailHeaderState extends State<CategoryDetailHeader> {
  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 48,
        width: 48,
        child: CircularProgressIndicator(),
      ),
    );
  }

  double heroOpacity = 1;

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.vHeight / 4;
    final backgroundColor = context.colorTheme.primaryContainer;
    return SliverAppBar(
      backgroundColor: backgroundColor,
      expandedHeight: maxHeight,
      collapsedHeight: kToolbarHeight,
      toolbarHeight: kToolbarHeight,
      floating: false,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: kToolbarHeight,
      leading: LeadingBackButton(backgroundColor: backgroundColor),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final flexHeight = constraints.maxHeight - context.vTopSafeHeight - kToolbarHeight;
          final scale = flexHeight / maxHeight;

          return FlexibleSpaceBar(
            expandedTitleScale: 1,
            collapseMode: CollapseMode.parallax,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1 - scale == 1 ? 1 : 0,
              child: Text(
                widget.category.title,
                style: context.typographyTheme.titleMedium.onPrimaryContainer.textStyle,
              ),
            ),
            background: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: widget.category.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          opacity: min(0.4, scale),
                        ),
                        color: context.colorTheme.primaryContainer,
                      ),
                    ),
                    placeholder: (context, url) => _buildLoading(),
                    // errorWidget: (context, url, error) => _buildCard(null, color, child),
                  ),
                ),
                Positioned.fill(
                  top: context.vTopSafeHeight * 2,
                  left: kLargePadding.left,
                  right: kLargePadding.right,
                  bottom: kMediumPadding.bottom,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.category.title,
                        textAlign: TextAlign.center,
                        style:
                            context.typographyTheme.titleMedium.onPrimaryContainer.textStyle,
                      ),
                      SizedBox(height: kMediumPadding.bottom),
                      Text(
                        widget.category.description,
                        textAlign: TextAlign.center,
                        style: context
                            .typographyTheme.subtitleMedium.onPrimaryContainer.textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
