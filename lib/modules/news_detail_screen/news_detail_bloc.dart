import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_news_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'news_detail_bloc.freezed.dart';
part 'news_detail_bloc.g.dart';

@freezed
class NewsDetailBlocState with _$NewsDetailBlocState {
  const factory NewsDetailBlocState({
    required LoadingState isLoading,
    NewsAbstractModel? newsAbstract,
    NewsModel? news,
  }) = _NewsDetailBlocState;

  factory NewsDetailBlocState.initialize() => const NewsDetailBlocState(
        isLoading: LoadingState.none,
      );

  factory NewsDetailBlocState.fromJson(Map<String, Object?> json) =>
      _$NewsDetailBlocStateFromJson(json);
}

class NewsDetailBloc extends HydratedCubit<NewsDetailBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;

  final INewsRepository newsRepository;

  NewsDetailBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.newsRepository,
  }) : super(NewsDetailBlocState.initialize());

  Future<void> init(String id) async {
    emit(state.copyWith(
      isLoading: LoadingState.loading,
    ));

    final news = await newsRepository.getDetailNews(id);

    emit(state.copyWith(
      isLoading: LoadingState.loading,
      news: news,
    ));

    emit(state.copyWith(
      isLoading: LoadingState.done,
    ));
  }

  @override
  NewsDetailBlocState? fromJson(Map<String, dynamic> json) {
    return NewsDetailBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NewsDetailBlocState state) {
    return state.toJson();
  }
}
