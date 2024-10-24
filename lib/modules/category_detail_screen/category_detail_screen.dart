import 'dart:math';

import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/art_detail_screen/art_detail_page.dart';
import 'package:art_for_all/modules/artist_detail_screen/artist_detail_screen.dart';
import 'package:art_for_all/modules/category_detail_screen/category_detail_bloc.dart';
import 'package:art_for_all/core/widgets/leading_back_button.dart';
import 'package:art_for_all/modules/community_detail_screen/community_detail_screen.dart';
import 'package:art_for_all/modules/dashboard_search_screen/dashboard_search_screen.dart';
import 'package:art_for_all/modules/event_detail_screen/event_detail_screen.dart';
import 'package:art_for_all/modules/news_detail_screen/news_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryDetailScreen extends StatefulWidget {
  static String name = 'category-detail-screen';
  static String pathParamId = 'id';

  final String id;
  final CategoryAbstractModel? extra;

  const CategoryDetailScreen({super.key, required this.id, this.extra});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final _bloc = locator.get<CategoryDetailBloc>();
  final navigator = locator.get<NavigationService>();

  @override
  void initState() {
    _bloc.init(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final abs = widget.extra;
    Widget? header;
    if (abs != null) {
      header = CategoryDetailHeader(
        category: abs,
        heroTag: abs.heroTag,
      );
    }
    return ColoredBox(
      color: context.colorTheme.background,
      child: BlocBuilder<CategoryDetailBloc, CategoryDetailBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          final category = state.category;
          if (category == null && abs == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (category != null && abs == null) {
            header = CategoryDetailHeader(
              category: category,
              heroTag: category.heroTag,
            );
          }

          return CustomScrollView(
            slivers: [
              header!,
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final result = state.result;
                  if (state.isLoading == LoadingState.loading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (category == null) {
                    return const SliverFillRemaining(child: SizedBox());
                  }

                  return SliverPadding(
                    padding: kMediumPadding,
                    sliver: SliverList.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final data = result[index];
                        final page = switch (data.searchType) {
                          SearchType.art => ArtDetailScreen.name,
                          SearchType.artist => ArtistDetailScreen.name,
                          SearchType.news => NewsDetailScreen.name,
                          SearchType.event => EventDetailScreen.name,
                          SearchType.community => CommunityDetailScreen.name,
                        };
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: kMediumPadding.bottom,
                          ),
                          child: SearchResultCardContainer(
                            onTap: () {
                              final current = navigator.homeUrl;
                              navigator.homeContext.push(
                                '$current/$page/${data.id}',
                                extra: data.toJson(),
                              );
                            },
                            data: data,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
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
    required this.heroTag,
  });

  final CategoryAbstractModel category;
  final String heroTag;

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
  void didUpdateWidget(covariant CategoryDetailHeader oldWidget) {
    if (oldWidget.heroTag == widget.heroTag) {
      return;
    }
    super.didUpdateWidget(oldWidget);
  }

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

          return Container(
            decoration: BoxDecoration(
              color: context.colorTheme.primaryContainer,
              border: Border(
                bottom: kExtraTinyBorder.copyWith(
                  color: context.colorTheme.onPrimaryContainer,
                ),
              ),
            ),
            child: FlexibleSpaceBar(
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
                    child: Hero(
                      tag: widget.heroTag,
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
                      ),
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
                          style: context
                              .typographyTheme.titleMedium.onPrimaryContainer.textStyle,
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
            ),
          );
        },
      ),
    );
  }
}
