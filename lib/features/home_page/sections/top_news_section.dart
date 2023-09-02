import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/features/news_page/widgets/news_card_container.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/navigation_service.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:recive/enums/loading_state.dart';

class HomePageTopNewsSections extends HookWidget {
  const HomePageTopNewsSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final bloc = useBloc<NewsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadNews();
      return;
    }, []);

    return context.checkLoadingState(state.loadingState) ??
        MultiSliver(
          children: [
            SliverToBoxAdapter(
              child: Text(
                "Top News Stories",
                style: context.textTheme.headlineSmall,
              ),
            ),
            const SliverGap(height: 12),
            SliverCardContainer(
              borderRadius: BorderRadius.circular(16),
              padding: kTinyPadding,
              sliver: SliverToBoxAdapter(
                child: LayoutBuilder(builder: (context, box) {
                  return SizedBox(
                    height: 120,
                    child: Builder(builder: (context) {
                      if (state.loadingState == LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.newsSpotlight.length + 1,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            if (index == state.newsSpotlight.length) {
                              return SeeMoreButton(
                                constraints: BoxConstraints.expand(
                                  width: box.maxWidth / 2,
                                ),
                                onTap: () => navigationService
                                    .navigateTo(NewsScreen.name),
                              );
                            }
                            final data = TopNewsCardContainerData.fromNews(
                              state.newsSpotlight[index],
                            );
                            return TopNewsCardContainer(
                              constraints: BoxConstraints.expand(
                                width: box.maxWidth / 1.4,
                              ),
                              data: data,
                            );
                          });
                    }),
                  );
                }),
              ),
            ),
          ],
        );
  }
}
