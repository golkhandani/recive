import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/utils/transformable_cubit.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'map_art_bloc.freezed.dart';
part 'map_art_bloc.g.dart';

@freezed
class MapArtBlocState with _$MapArtBlocState {
  const factory MapArtBlocState({
    required LoadingState isLoadingArts,
    required List<ArtAbstractModel> arts,
    required LatLng center,
    required String query,
    required bool hasPositionChanged,
    required ArtAbstractModel? focusedArt,
  }) = _MapArtBlocState;

  factory MapArtBlocState.initialize() => const MapArtBlocState(
        isLoadingArts: LoadingState.none,
        arts: [],
        focusedArt: null,
        center: LatLng(51.5, -0.09),
        query: '',
        hasPositionChanged: false,
      );

  factory MapArtBlocState.fromJson(Map<String, Object?> json) =>
      _$MapArtBlocStateFromJson(json);
}

class MapArtBloc extends TransformableCubit<MapArtBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final IArtRepository artRepository;

  MapArtBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.artRepository,
  }) : super(MapArtBlocState.initialize());

  Future<void> init(LatLng? center) async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
    ));
    final featuredArts = await artRepository.getFeaturedArts(center);
    emit(
      state.copyWith(
        arts: featuredArts,
        focusedArt: featuredArts.first,
        isLoadingArts: LoadingState.done,
        center: center ?? state.center,
      ),
    );
  }

  Future<void> setFocusedArt(ArtAbstractModel? art) async {
    if (art == null) {
      return;
    }
    emit(state.copyWith(
      focusedArt: art,
      hasPositionChanged: false,
    ));
  }

  Future<void> searchByCenter() async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
    ));
    final featuredArts = await artRepository.getFeaturedArts(state.center);
    emit(state.copyWith(
      arts: featuredArts,
      focusedArt: featuredArts.first,
      isLoadingArts: LoadingState.done,
    ));
  }

  Future<void> onCenterChanged(LatLng center) async {
    emit(state.copyWith(
      center: center,
      hasPositionChanged: true,
    ));
  }

  Future<void> filter(LatLng center, double? distance, String? query) async {
    withDebounce(() async {
      if (query == null) {
        return;
      }
      emit(state.copyWith(
        isLoadingArts: LoadingState.loading,
        hasPositionChanged: false,
      ));
      final featuredArts = await artRepository.getFeaturedArts(center);
      emit(state.copyWith(
        arts: featuredArts,
        focusedArt: featuredArts.first,
        isLoadingArts: LoadingState.done,
      ));
    });
  }
}
