import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:recive/core/components/quick_search_header/bloc/quick_search_header_bloc.dart';
import 'package:recive/core/components/screen_safe_area_header.dart';
import 'package:recive/core/components/sliver_gap.dart';
import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/search_page/cubits/search_cubit.dart';
import 'package:recive/modules/search_page/widgets/search_filter_bar.dart';
import 'package:recive/modules/search_page/widgets/search_filter_section.dart';
import 'package:recive/modules/search_page/widgets/search_result_animated_list.dart';
import 'package:recive/shared/constants/ui_constants.dart';
import 'package:recive/shared/extensions/context_ui_extension.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';

class SearchScreen extends StatefulHookWidget {
  static const name = 'search';
  static const keywordQueryKey = 'keyword';
  const SearchScreen({
    super.key,
    this.keyword,
  });

  final String? keyword;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final textEditingController = useTextEditingController();

    final bloc = useBloc<SearchCubit>();
    final state = useBlocBuilder(bloc);

    final quickSearchBloc = useBloc<QuickSearchHeaderBloc>();

    useBlocComparativeListener<SearchCubit, SearchState>(
      bloc,
      (bloc, current, context) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          for (var item in current.searchedItems) {
            final index = current.searchedItems.indexOf(item);
            _listKey.currentState?.insertItem(
              index,
              duration: const Duration(milliseconds: 200),
            );
          }
        });
      },
      listenWhen: (o, n) => o.searchedItems.length != n.searchedItems.length,
    );

    void textEditingListener() {
      final query = textEditingController.text;
      if (query.length > 1 && scrollController.hasClients) {
        bloc.loadSearchedItems(query);
        scrollController.jumpTo(0);
      }
    }

    void loadMoreOnScroll() {
      if (state.loadingState == LoadingState.loading || state.loadingState == LoadingState.updating) {
        return;
      }
      if (scrollController.offset + 10 > scrollController.position.maxScrollExtent) {
        bloc.loadMoreSearchedItems();
      }
    }

    useEffect(() {
      bloc.loadSearchedKeywords();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        textEditingController.addListener(textEditingListener);
        scrollController.addListener(loadMoreOnScroll);

        if (widget.keyword != null) {
          textEditingController.text = widget.keyword!;
        }
      });

      bloc.loadSearchedItems(widget.keyword ?? '');
      return () {
        textEditingController.dispose();
        scrollController.dispose();
      };
    }, []);

    useEffect(
      () {
        textEditingController.text = widget.keyword ?? '';
        bloc.loadSearchedItems(widget.keyword);
        return;
      },
      [widget.keyword],
    );

    final showFilters = useState(false);

    return ColoredBox(
      color: context.colorTheme.background,
      child: LayoutBuilder(builder: (context, box) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            ScreenSafeAreaHeader(
              title: 'Search Routes',
              elevation: false,
              children: [
                SearchFilterBar(
                  quickSearchBloc: quickSearchBloc,
                  textEditingController: textEditingController,
                  onFilterClicked: () => showFilters.value = !showFilters.value,
                  onSearchItemSelected: (text) => bloc.loadSearchedItems(text),
                  onSearchTextChanged: (text) =>
                      text.isEmpty ? bloc.loadSearchedItems(null) : bloc.loadSearchedItems(text),
                )
              ],
            ),
            ...[
              SearchFilterSection(
                bloc: bloc,
                showFilters: showFilters,
                selectedDistanceFilter: state.distanceFilter,
                searchedkeywords: state.searchedkeywords,
                onKeywordTap: (keyword) {
                  textEditingController.text = keyword;
                  showFilters.value = false;
                },
              ),
            ],
            const SliverGap(height: 12),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: kTinyPadding.horizontal / 2).copyWith(bottom: 112),
              sliver: MultiSliver(
                children: [
                  if (state.loadingKeywordsState == LoadingState.loading ||
                      state.loadingState == LoadingState.loading) ...[
                    kSkeletonSectionLoadingBox,
                  ],
                  if (state.loadingState == LoadingState.done || state.loadingState == LoadingState.updating) ...[
                    SearchResultAnimatedList(
                      listKey: _listKey,
                      initialItem: state.searchedItems,
                    )
                  ]
                ],
              ),
            ),
            if (state.loadingState == LoadingState.updating)
              SliverPadding(
                padding: EdgeInsets.only(bottom: context.footerHeight + 16),
                sliver: kSliverBoxAnimatedLoading,
              ),
          ],
        );
      }),
    );
  }
}
