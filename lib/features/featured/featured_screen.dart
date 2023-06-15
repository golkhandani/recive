import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:recive/components/async_search_bar.dart';
import 'package:recive/components/big_square_card.dart';
import 'package:recive/components/category_horizontal_card.dart';
import 'package:recive/features/featured/category_section/bloc/category_section_bloc.dart';
import 'package:recive/features/featured/greeting_header/greeting_header_component.dart';
import 'package:recive/features/featured/quick_search_header/quick_search_header_component.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/sliver_header_delegate.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:recive/router/router_service.dart';

class FeaturedScreen extends StatelessWidget {
  static const name = 'featured';
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: SliverHeaderDelegate(
            child: const PreferredSize(
              preferredSize: Size.fromHeight(64),
              child: GreetingHeader(),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate(
            child: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: QuickSearchHeader(),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: CategorySection(),
        ),
        for (var i = 1; i < 4; i++) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Recives for Today",
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Builder(builder: (context) {
                    final images = <String>[]..addAll(recive.imageUrls);
                    images.shuffle();
                    return BigSquareCard(
                        data: recive.copyWith(imageUrls: images.toList()));
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}

class CategorySection extends HookWidget {
  const CategorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<CategorySectionBloc>();
    final state = useBlocBuilder(bloc);
    useEffect(() {
      bloc.add(const CategorySectionEvent.load());
      return;
    }, []);
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          if (!state.isLoading) ...[
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) =>
                    CategoryHorizontalCard(data: state.categories[i]),
                separatorBuilder: (_, i) => const SizedBox(width: 16),
                itemCount: state.categories.length,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
