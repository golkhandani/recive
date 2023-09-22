import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/featured_page/models/art_abstract_model.dart';
import 'package:recive/features/near_me_page/repos/nearby_arts_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'near_by_cubit.freezed.dart';
part 'near_by_cubit.g.dart';

@freezed
class NearbyState with _$NearbyState {
  const factory NearbyState({
    required int preSelectedIndex,
    required List<ArtAbstractModel> nearbyArts,
    required LoadingState loadingState,
    required bool isRefreshLoading,
    required String? queryFilter,

    ///
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
  }) = _NearbyState;

  factory NearbyState.initialize() => const NearbyState(
        preSelectedIndex: 0,
        nearbyArts: [],
        loadingState: LoadingState.none,
        isRefreshLoading: false,
        queryFilter: null,

        ///
        latitude: 0,
        longitude: 0,
        minDistance: 0,
        maxDistance: 0,
      );

  factory NearbyState.fromJson(Map<String, Object?> json) =>
      _$NearbyStateFromJson(json);
}

class NearbyCubit extends MaybeEmitHydratedCubit<NearbyState> {
  final INearbyArtRepo repo;
  NearbyCubit({
    required this.repo,
  }) : super(NearbyState.initialize());

  Future<void> loadNearbyArts({
    required double latitude,
    required double longitude,
    required double minDistance,
    required double maxDistance,
    bool onBackground = false,
  }) async {
    if (!onBackground) {
      maybeEmit(state.copyWith(
        loadingState: LoadingState.loading,
      ));
    }
    maybeEmit(state.copyWith(
      isRefreshLoading: true,
    ));

    final data = await repo.getNearbyArts(
      latitude: latitude,
      longitude: longitude,
      minDistance: minDistance,
      maxDistance: maxDistance,
      text: state.queryFilter,
    );

    maybeEmit(state.copyWith(
      preSelectedIndex: 0,
      nearbyArts: data,
      loadingState: LoadingState.done,
      isRefreshLoading: false,

      ///
      latitude: latitude,
      longitude: longitude,
      minDistance: minDistance,
      maxDistance: maxDistance,
    ));
  }

  Future<void> updateQueryFilter(String? queryFilter) async {
    maybeEmit(state.copyWith(
      queryFilter: queryFilter,
      loadingState: LoadingState.updating,
    ));
    loadNearbyArts(
      latitude: state.latitude,
      longitude: state.longitude,
      minDistance: state.minDistance,
      maxDistance: state.maxDistance,
      onBackground: true,
    );
  }

  Future<void> changeSelectedIndex(int index) async {
    maybeEmit(state.copyWith(
      preSelectedIndex: index,
    ));
  }

  @override
  NearbyState? fromJson(Map<String, dynamic> json) {
    return NearbyState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NearbyState state) {
    return state.toJson();
  }
}
