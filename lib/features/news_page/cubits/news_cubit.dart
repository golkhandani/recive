import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/categories_page/cubits/category_fake_data.dart';
import 'package:recive/features/news_page/models/news_model.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'news_cubit.freezed.dart';
part 'news_cubit.g.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    required LoadingState selectedLoadingState,
    required NewsModel? selected,
    required List<NewsModel> news,
    required List<NewsModel> newsSpotlight,
    required LoadingState loadingState,
  }) = _NewsState;

  factory NewsState.initialize() => const NewsState(
        selectedLoadingState: LoadingState.none,
        selected: null,
        //
        news: [],
        newsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory NewsState.fromJson(Map<String, Object?> json) =>
      _$NewsStateFromJson(json);
}

class NewsCubit extends MaybeEmitHydratedCubit<NewsState> {
  NewsCubit() : super(NewsState.initialize());

  Future<void> loadSelectedNews(String id) async {
    maybeEmit(state.copyWith(
      selectedLoadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    maybeEmit(state.copyWith(
      selected: mockNews.firstWhere((element) => element.id == id),
      selectedLoadingState: LoadingState.done,
    ));
  }

  Future<void> emptySelectedNews() async {
    maybeEmit(state.copyWith(
      selected: null,
      selectedLoadingState: LoadingState.none,
    ));
  }

  Future<void> loadNews() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    mockNews.shuffle();
    maybeEmit(state.copyWith(
      news: mockNews,
      newsSpotlight: mockNews.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  NewsState? fromJson(Map<String, dynamic> json) {
    return NewsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NewsState state) {
    return state.toJson();
  }
}
