import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'featured_art_bloc.freezed.dart';
part 'featured_art_bloc.g.dart';

@freezed
class FeaturedArtBlocState with _$FeaturedArtBlocState {
  const factory FeaturedArtBlocState({
    required LoadingState isLoadingFeaturedArts,
    required List<ArtAbstractModel> featuredArts,
  }) = _FeaturedArtBlocState;

  factory FeaturedArtBlocState.initialize() => const FeaturedArtBlocState(
        isLoadingFeaturedArts: LoadingState.none,
        featuredArts: [],
      );

  factory FeaturedArtBlocState.fromJson(Map<String, Object?> json) =>
      _$FeaturedArtBlocStateFromJson(json);
}

class FeaturedArtBloc extends HydratedCubit<FeaturedArtBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final IArtRepository artRepository;

  FeaturedArtBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.artRepository,
  }) : super(FeaturedArtBlocState.initialize());

  Future<void> init() async {
    emit(state.copyWith(isLoadingFeaturedArts: LoadingState.loading));
    final featuredArts = await artRepository.getFeaturedArts(null);
    emit(state.copyWith(
      featuredArts: featuredArts,
      isLoadingFeaturedArts: LoadingState.done,
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
