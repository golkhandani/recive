import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/ioc/i_category_repository.dart';
import 'package:art_for_all/core/ioc/i_community_repository.dart';
import 'package:art_for_all/core/ioc/i_event_repository.dart';
import 'package:art_for_all/core/ioc/i_news_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'featured_art_bloc.freezed.dart';
part 'featured_art_bloc.g.dart';

@freezed
class FeaturedArtBlocState with _$FeaturedArtBlocState {
  const factory FeaturedArtBlocState({
    required LoadingState isLoading,
    required List<ArtAbstractModel> featuredArts,
    required List<NewsAbstractModel> news,
    required List<CategoryAbstractModel> categories,
    required List<ArtistAbstractModel> artists,
    required List<EventAbstractModel> events,
    required List<CommunityAbstractModel> communities,
    ArtAbstractModel? dayArt,
  }) = _FeaturedArtBlocState;

  factory FeaturedArtBlocState.initialize() => const FeaturedArtBlocState(
        isLoading: LoadingState.none,
        featuredArts: [],
        news: [],
        categories: [],
        artists: [],
        events: [],
        communities: [],
      );

  factory FeaturedArtBlocState.fromJson(Map<String, Object?> json) =>
      _$FeaturedArtBlocStateFromJson(json);
}

class FeaturedArtBloc extends HydratedCubit<FeaturedArtBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final IArtRepository artRepository;
  final INewsRepository newsRepository;
  final ICategoryRepository categoryRepository;
  final IArtistRepository artistRepository;
  final IEventRepository eventRepository;
  final ICommunityRepository communityRepository;

  FeaturedArtBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.artRepository,
    required this.newsRepository,
    required this.categoryRepository,
    required this.artistRepository,
    required this.eventRepository,
    required this.communityRepository,
  }) : super(FeaturedArtBlocState.initialize());

  Future<void> init() async {
    clear();
    emit(state.copyWith(isLoading: LoadingState.loading));
    final dayArt = await artRepository.getDayArt(null);
    final featuredArts = await artRepository.getFeaturedArts(null);
    final featuredNews = await newsRepository.getFeaturedNews(null);
    final categories = await categoryRepository.getCategories();
    final artists = await artistRepository.getArtists();
    final events = await eventRepository.getEvents();
    final communities = await communityRepository.getCommunities();
    emit(state.copyWith(
      dayArt: dayArt,
      featuredArts: featuredArts,
      news: featuredNews,
      categories: categories,
      artists: artists,
      events: events,
      communities: communities,
      isLoading: LoadingState.done,
    ));
  }

  @override
  FeaturedArtBlocState? fromJson(Map<String, dynamic> json) {
    return FeaturedArtBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FeaturedArtBlocState state) {
    return state.toJson();
  }
}
