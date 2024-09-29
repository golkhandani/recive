import 'package:art_for_all/core/constants.dart';
import 'package:art_for_all/core/extensions/context_ui_extension.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/theme/theme.dart';
import 'package:art_for_all/modules/featured_art_screen/featured_art_bloc.dart';
import 'package:art_for_all/modules/featured_art_screen/widgets/art_card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  static String name = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = locator.get<FeaturedArtBloc>();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = Container(
      color: context.colorTheme.primaryContainer,
      padding: EdgeInsets.only(top: context.vTopSafeHeight),
      child: Material(
        color: context.colorTheme.primaryContainer,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Arts picked for you!',
            style: context.typographyTheme.titleSmall.textStyle.copyWith(
              color: context.colorTheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
    return BlocBuilder<FeaturedArtBloc, FeaturedArtBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            PinnedHeaderSliver(child: header),
            // ItemList(items: state.featuredArts),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: kMediumPadding.right,
                vertical: kLargePadding.top,
              ),
              sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.featuredArts.length,
                    (context, index) {
                      final data = ArtCardContainerData.fromAbstractArt(
                        state.featuredArts[index],
                      );
                      return ArtCardContainer(
                        hero: HomeScreen.name + data.id,
                        constraints: const BoxConstraints.expand(),
                        data: data,
                      );
                    },
                  ),
                  gridDelegate: SliverStairedGridDelegate(
                    startCrossAxisDirectionReversed: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    pattern: const [
                      StairedGridTile(1, 2),
                      StairedGridTile(0.4, 0.5),
                      StairedGridTile(0.6, 0.75),
                      StairedGridTile(0.4, 0.5),
                      StairedGridTile(0.6, 0.75),
                      StairedGridTile(1, 2),
                    ],
                  )),
            )
          ],
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.items = const [],
  });

  final List<ArtAbstractModel> items;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = items[index];
          return Card(
            color: colorScheme.onSecondary,
            child: ListTile(
              textColor: colorScheme.secondary,
              title: Text(item.title),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
