import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/card_container.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/detail_page/detail_screen.dart';
import 'package:recive/features/home_page/sections/top_news_section.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/router/navigation_service.dart';
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
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: 'News',
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16)
                .copyWith(bottom: context.footerHeight + 16),
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

class TopNewsExpandedCardContainer extends HookWidget {
  const TopNewsExpandedCardContainer({
    super.key,
    required this.data,
  });

  final TopNewsCardContainerData data;

  @override
  Widget build(BuildContext context) {
    final navigationService = locator.get<NavigationService>();
    final style = context.textTheme.headlineSmall!.copyWith(
      color: context.theme.colorScheme.onBackground.withOpacity(0.4),
      fontWeight: FontWeight.bold,
    );

    final rotateTitles = [
      RotateAnimatedText(
        data.source,
        textStyle: style,
        textAlign: TextAlign.center,
      ),
      RotateAnimatedText(
        data.title,
        textStyle: style,
        textAlign: TextAlign.center,
      ),
      RotateAnimatedText(
        DateFormat.MMMd().format(data.publishDate),
        textStyle: style,
        textAlign: TextAlign.center,
      ),
    ]..shuffle();
    return InkWell(
      onTap: () => navigationService.navigateTo(
        NewsScreen.name + DetailScreen.name,
        pathParameters: {
          DetailScreen.pathParamId: data.id,
          DetailScreen.pathParamType: DetailType.news.name
        },
      ),
      child: Hero(
        tag: DetailScreen.name + DetailType.news.name + data.id,
        child: CardContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.theme.colorScheme.background,
            ),
            child: Column(
              children: [
                Container(
                  height: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: TopNewsCardContainerData
                            .sourceToColorMap[data.source] ??
                        Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedTextKit(
                        animatedTexts: rotateTitles,
                        totalRepeatCount: 4,
                        pause: const Duration(milliseconds: 300),
                        displayFullTextOnTap: false,
                        stopPauseOnTap: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    header: Text(
                      data.title,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.theme.colorScheme.onBackground,
                      ),
                    ),
                    collapsed: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Iconify(
                              Bx.calendar_event,
                              color: context.theme.colorScheme.onBackground,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat.MMMd().format(data.publishDate),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.theme.colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Iconify(
                              Mdi.volume_source,
                              color: context.theme.colorScheme.onBackground,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.source,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall!.copyWith(
                                  color: context.theme.colorScheme.onBackground,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                    expanded: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Iconify(
                                Bx.calendar_event,
                                color: context.theme.colorScheme.onBackground,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat.MMMd().format(data.publishDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall!.copyWith(
                                  color: context.theme.colorScheme.onBackground,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Iconify(
                                Mdi.volume_source,
                                color: context.theme.colorScheme.onBackground,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  data.source,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.labelSmall!.copyWith(
                                    color:
                                        context.theme.colorScheme.onBackground,
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
                              color: context.theme.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
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
        ),
      ),
    );
  }
}
