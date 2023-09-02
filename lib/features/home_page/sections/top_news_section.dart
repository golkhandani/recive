import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/home_screen.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/news_page/models/news_model.dart';
import 'package:recive/features/news_page/news_screen.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
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
              padding: const EdgeInsets.all(12),
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

class TopNewsCardContainerData {
  final String id;
  final String title;
  final String description;
  final DateTime publishDate;
  final String source;

  TopNewsCardContainerData({
    required this.id,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.source,
  });

  static TopNewsCardContainerData fromNews(NewsModel n) =>
      TopNewsCardContainerData(
        id: n.id,
        title: n.title,
        description: n.description,
        publishDate: n.publishDate,
        source: n.source,
      );

  static Map<String, Color> sourceToColorMap = {
    'TechNews': Colors.red,
    'Science Times': Colors.greenAccent,
    'Environmental Watch': Colors.lightBlue,
    'SpaceNews': Colors.blue,
    'Community Gazette': Colors.pink
  };
}

class TopNewsCardContainer extends HookWidget {
  const TopNewsCardContainer({
    super.key,
    required this.data,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final TopNewsCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final color = context.randomColor;
    final child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Iconify(
              Bx.calendar_event,
              color: color.lighten(0.7),
              size: 12,
            ),
            const SizedBox(width: 4),
            Text(
              DateFormat.MMMd().format(data.publishDate),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall!.copyWith(
                color: context.theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Iconify(
              Mdi.volume_source,
              color: color.lighten(0.7),
              size: 12,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                data.source,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          data.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium!.copyWith(
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
          DetailScreen.pathParamType: DetailType.news.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.news.name + data.id,
        child: Container(
          constraints: constraints,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.darken(),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color,
                color.darken(),
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: child,
        ),
      ),
    );
  }
}
