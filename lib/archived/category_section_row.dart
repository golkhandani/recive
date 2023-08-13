import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/archived/featured_page/category_section/bloc/category_section_bloc.dart';
import 'package:recive/components/category_horizontal_card.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';

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
    return SizedBox(
      height: context.vHeight / 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Categories",
              style: context.textTheme.titleSmall!.copyWith(
                color: context.schema.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (state.isLoading) ...[
            const Center(child: kLoadingBox),
          ],
          if (!state.isLoading) ...[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
