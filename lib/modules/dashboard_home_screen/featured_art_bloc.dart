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
import 'package:art_for_all/modules/art_detail_screen/user_interaction_bloc.dart';
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

  void subsribe(UserInteractionBloc interactionBloc) {
    interactionBloc.stream.listen((s) {
      // update dayArt
      if (s.interactions.containsKey(state.dayArt?.id)) {
        emit(state.copyWith(
          dayArt: state.dayArt?.copyWith(
            userInteraction: s.interactions[state.dayArt?.id]!.$2,
          ),
        ));
      }
      // update featuredArts
      final fas = List<ArtAbstractModel>.from(state.featuredArts);
      for (var i = 0; i < fas.length; i++) {
        if (s.interactions.containsKey(fas[i].id)) {
          fas[i] = fas[i].copyWith(userInteraction: s.interactions[fas[i].id]!.$2);
        }
      }
      emit(state.copyWith(featuredArts: fas));

      final es = List<EventAbstractModel>.from(state.events);
      for (var i = 0; i < es.length; i++) {
        if (s.interactions.containsKey(es[i].id)) {
          es[i] = es[i].copyWith(userInteraction: s.interactions[es[i].id]!.$2);
        }
      }
      emit(state.copyWith(events: es));
    });
  }

  Future<void> init({bool refresh = false}) async {
    clear();
    emit(state.copyWith(isLoading: refresh ? LoadingState.updating : LoadingState.loading));
    final [dayArt, featuredArts, artists, events] = await Future.wait([
      artRepository.getDayArt(null),
      artRepository.getFeaturedArts(null),
      artistRepository.getArtists(),
      eventRepository.getEvents(),
    ]);
    emit(state.copyWith(
      dayArt: dayArt as ArtAbstractModel,
      featuredArts: featuredArts as List<ArtAbstractModel>,
      news: [],
      categories: [],
      artists: artists as List<ArtistAbstractModel>,
      events: events as List<EventAbstractModel>,
      communities: [],
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
