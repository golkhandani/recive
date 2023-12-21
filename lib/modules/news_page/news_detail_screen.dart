import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_card_container.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/news_page/cubits/news_cubit.dart';
import 'package:recive/modules/news_page/widgets/news_card_container.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/color_extentions.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/string_extensions.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/router/extra_data.dart';

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
    final infoStyle = context.textTheme.body1.onPrimaryContainer.style;
    final color =
        TopNewsCardContainerData.sourceToColorMap[data?.source]?.darken(.3) ??
            context.randomColor;
    return ColoredBox(
      color: context.colorScheme.background,
      child: CustomScrollView(
        slivers: [
          ScreenSafeAreaHeader(
            title: (summary?.title ?? data?.title ?? '').dynamicSub(20),
          ),
          SliverPadding(
            padding: kMediumPadding.copyWith(
              bottom: context.footerHeight + 32,
            ),
            sliver: MultiSliver(
              children: [
                Builder(builder: (context) {
                  if (summary == null && data == null) {
                    return kSliverFillAnimatedLoading;
                  }

                  return MultiSliver(
                    children: [
                      Builder(builder: (context) {
                        if (state.selectedLoadingState ==
                                LoadingState.loading ||
                            data == null) {
                          return kSliverFillAnimatedLoading;
                        }

                        final style = context.textTheme.headerLarge
                            .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                            .style;
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
                              borderRadius: kMediumBorderRadius,
                              padding: kTinyPadding,
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  height: 88,
                                  padding: kTinyPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: kSmallBorderRadius,
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
                              borderRadius: kMediumBorderRadius,
                              padding: kTinyPadding,
                              sliver: SliverToBoxAdapter(
                                child: Container(
                                  padding: kTinyPadding,
                                  decoration: BoxDecoration(
                                    borderRadius: kSmallBorderRadius,
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
