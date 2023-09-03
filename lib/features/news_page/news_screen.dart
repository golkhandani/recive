import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/news_page/widgets/news_card_container.dart';
import 'package:recive/features/news_page/widgets/news_expanded_card_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NewsScreen extends HookWidget {
  static const name = 'news';
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<NewsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadNews();
      return;
    }, []);

    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          const ScreenSafeAreaHeader(
            title: 'News',
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
                          itemCount: state.news.length,
                          itemBuilder: (context, index) {
                            final data = TopNewsCardContainerData.fromNews(
                              state.news[index],
                            );
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: TopNewsExpandedCardContainer(
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
