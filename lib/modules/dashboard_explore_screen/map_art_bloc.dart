import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_search_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/category_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:art_for_all/utils/transformable_cubit.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'map_art_bloc.freezed.dart';
part 'map_art_bloc.g.dart';

@freezed
class MapArtBlocState with _$MapArtBlocState {
  const MapArtBlocState._();
  const factory MapArtBlocState({
    required LoadingState isLoadingArts,
    required List<SearchableAbstractModel> arts,
    required LatLng center,
    required String? query,
    required double? distance,
    required CategoryAbstractModel? category,
    required EntityType? type,
    required bool hasPositionChanged,
    required SearchableAbstractModel? focusedArt,
  }) = _MapArtBlocState;

  bool get hasFilter => (distance ?? category ?? type) != null;

  factory MapArtBlocState.initialize() => const MapArtBlocState(
        isLoadingArts: LoadingState.none,
        arts: [],
        focusedArt: null,
        center: LatLng(51.5, -0.09),
        query: null,
        category: null,
        distance: null,
        type: null,
        hasPositionChanged: false,
      );

  factory MapArtBlocState.fromJson(Map<String, Object?> json) =>
      _$MapArtBlocStateFromJson(json);
}

class MapArtBloc extends TransformableCubit<MapArtBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final ISearchRepository searchRepository;

  MapArtBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.searchRepository,
  }) : super(MapArtBlocState.initialize());

  Future<void> init(LatLng? center) async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
    ));
    final featuredArts = await searchRepository.searchByCoordinate(
      coordinates: center,
      categoryId: state.category?.id,
      distance: state.distance,
      query: state.query,
      type: state.type,
    );
    emit(
      state.copyWith(
        arts: featuredArts,
        focusedArt: featuredArts.isEmpty ? null : featuredArts.first,
        isLoadingArts: LoadingState.done,
        center: center ?? state.center,
      ),
    );
  }

  Future<void> setFocusedArt(SearchableAbstractModel? art) async {
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
    final featuredArts = await searchRepository.searchByCoordinate(
      coordinates: state.center,
      categoryId: state.category?.id,
      distance: state.distance,
      query: state.query,
      type: state.type,
    );
    emit(state.copyWith(
      arts: featuredArts,
      focusedArt: featuredArts.isNotEmpty ? featuredArts.first : null,
      isLoadingArts: LoadingState.done,
    ));
  }

  Future<void> onCenterChanged(LatLng center) async {
    emit(state.copyWith(
      center: center,
      hasPositionChanged: true,
    ));
  }

  _search() {
    withDebounce(() async {
      final featuredArts = await searchRepository.searchByCoordinate(
        coordinates: state.center,
        categoryId: state.category?.id,
        distance: state.distance,
        query: state.query,
        type: state.type,
      );
      emit(state.copyWith(
        arts: featuredArts,
        focusedArt: featuredArts.isNotEmpty ? featuredArts.first : null,
        isLoadingArts: LoadingState.done,
      ));
    });
  }

  Future<void> updateType(EntityType? type) async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
      type: type,
    ));
    _search();
  }

  Future<void> resetFilters() async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
      category: null,
      distance: null,
      type: null,
    ));
    _search();
  }

  Future<void> updateCategory(CategoryAbstractModel? cat) async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
      category: cat,
    ));
    _search();
  }

  Future<void> updateDistance(double? distance) async {
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
      distance: distance,
    ));
    _search();
  }

  Future<void> filter(LatLng center, String? query) async {
    if (query == null) {
      return;
    }
    emit(state.copyWith(
      isLoadingArts: LoadingState.loading,
      hasPositionChanged: false,
      query: query,
    ));
    withDebounce(() async {
      final featuredArts = await searchRepository.searchByCoordinate(
        coordinates: center,
        categoryId: state.category?.id,
        distance: state.distance,
        query: query,
        type: state.type,
      );
      emit(state.copyWith(
        arts: featuredArts,
        focusedArt: featuredArts.isNotEmpty ? featuredArts.first : null,
        isLoadingArts: LoadingState.done,
      ));
    });
  }
}
