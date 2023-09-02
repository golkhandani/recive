import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/news_page/models/news_model.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'news_cubit.freezed.dart';
part 'news_cubit.g.dart';

List<NewsModel> mockNews = [
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4f',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features.',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1220a3f4d',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  NewsModel(
    id: '1b9466aa-83c3-4f1a-9f2d-44c1260a3f4d',
    title: 'Tech Giant Unveils New Smartphone Model',
    description:
        'The tech company announced its latest smartphone with advanced features.',
    publishDate: DateTime(2023, 8, 19, 10, 0),
    source: 'TechNews',
  ),
  NewsModel(
    id: '2e9b61d8-79a1-4f18-950f-bfd10003e7e2',
    title: 'Scientists Discover New Species of Bird',
    description:
        'Researchers identified a previously unknown bird species in a remote forest.',
    publishDate: DateTime(2023, 8, 18, 15, 30),
    source: 'Science Times',
  ),
  NewsModel(
    id: '3c802d10-476b-42c0-8e1a-785f6c8210d4',
    title: 'New Study on Climate Change Impact',
    description:
        'A recent study reveals alarming effects of climate change on ocean temperatures.',
    publishDate: DateTime(2023, 8, 17, 12, 15),
    source: 'Environmental Watch',
  ),
  NewsModel(
    id: '4f671c11-01f2-4b09-9f92-eb27ebe4d65f',
    title: 'Space Exploration Milestone Achieved',
    description:
        'Astronauts successfully completed a record-breaking spacewalk mission.',
    publishDate: DateTime(2023, 8, 16, 9, 45),
    source: 'SpaceNews',
  ),
  NewsModel(
    id: '5a6f20d5-ff77-4e66-aa3c-723a9486c995',
    title: 'Local Community Celebrates Annual Festival',
    description:
        'Residents gather for a festive celebration showcasing cultural heritage.',
    publishDate: DateTime(2023, 8, 15, 17, 0),
    source: 'Community Gazette',
  ),
  // Add more news summaries here...
];

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    required List<NewsModel> news,
    required List<NewsModel> newsSpotlight,
    required LoadingState loadingState,
  }) = _NewsState;

  factory NewsState.initialize() => const NewsState(
        news: [],
        newsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory NewsState.fromJson(Map<String, Object?> json) =>
      _$NewsStateFromJson(json);
}

class NewsCubit extends MaybeEmitHydratedCubit<NewsState> {
  NewsCubit() : super(NewsState.initialize());

  Future<void> loadNews() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
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
