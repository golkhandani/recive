import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:intl/intl.dart';
import 'package:recive/components/screen_safe_area_header.dart';
import 'package:recive/components/sliver_card_container.dart';
import 'package:recive/components/sliver_gap.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/extensions/string_extensions.dart';
import 'package:recive/features/news_page/cubits/news_cubit.dart';
import 'package:recive/features/news_page/widgets/news_card_container.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:recive/layout/ui_constants.dart';
import 'package:recive/router/extra_data.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NewsDetailScreen extends HookWidget {
  static const name = 'news_detail';
  static const pathParamId = 'id';
  const NewsDetailScreen({
    super.key,
    required this.id,
    this.extra,
  });

  final String id;
  final ExtraData<NewsSummaryData>? extra;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc<NewsCubit>();
    final state = useBlocBuilder(bloc);

    useEffect(() {
      bloc.loadSelectedNews(id);
      return () => bloc.emptySelectedNews();
    }, []);

    final data = state.selected;
    final summary = extra?.summary;
    final infoStyle = context.textTheme.bodyLarge!.copyWith(
      color: context.theme.colorScheme.onPrimaryContainer,
    );
    final color =
        TopNewsCardContainerData.sourceToColorMap[data?.source]?.darken(.3) ??
            context.randomColor;
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            color: context.theme.primaryColor,
            title: summary?.title ?? data?.title ?? '',
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: MultiSliver(
              children: [
                SliverCardContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: kTinyPadding,
                  sliver: SliverToBoxAdapter(
                    child: Hero(
                      tag: extra?.heroTag ?? extra.hashCode,
                      child: Container(
                        padding: kTinyPadding,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            summary?.title ?? data?.title ?? '',
                            style: infoStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverGap(height: 12),
                Builder(builder: (context) {
                  if (summary == null && data == null) {
                    return kSliverFillLoading;
                  }

                  return MultiSliver(
                    children: [
                      Builder(builder: (context) {
                        if (state.selectedLoadingState ==
                                LoadingState.loading ||
                            data == null) {
                          return kSliverFillLoading;
                        }

                        final style = context.textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
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
                        return MultiSliver(
                          children: [
                            SliverCardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: kTinyPadding,
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  height: 88,
                                  padding: kTinyPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: color,
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: rotateTitles,
                                    pause: const Duration(milliseconds: 300),
                                    displayFullTextOnTap: false,
                                    stopPauseOnTap: false,
                                    repeatForever: true,
                                  ),
                                ),
                              ),
                            ),
                            const SliverGap(height: 12),
                            SliverCardContainer(
                              borderRadius: BorderRadius.circular(16),
                              padding: kTinyPadding,
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  padding: kTinyPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      data.description,
                                      style: infoStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SliverGap(height: 12),
                          ],
                        );
                      })
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
