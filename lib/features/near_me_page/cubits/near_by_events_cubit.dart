import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'near_by_events_cubit.freezed.dart';
part 'near_by_events_cubit.g.dart';

@freezed
class NearbyEventsState with _$NearbyEventsState {
  const factory NearbyEventsState({
    required int preSelectedEventIndex,
    required List<NearbyEvent> nearbyEvents,
    required LoadingState loadingState,
    required bool isRefreshLoading,
  }) = _NearbyEventsState;

  factory NearbyEventsState.initialize() => const NearbyEventsState(
        preSelectedEventIndex: 0,
        nearbyEvents: [],
        loadingState: LoadingState.none,
        isRefreshLoading: false,
      );

  factory NearbyEventsState.fromJson(Map<String, Object?> json) =>
      _$NearbyEventsStateFromJson(json);
}

class NearbyEventsCubit extends MaybeEmitHydratedCubit<NearbyEventsState> {
  final INearbyEventRepo repo;
  NearbyEventsCubit({
    required this.repo,
  }) : super(NearbyEventsState.initialize());

  Future<void> loadNearbyEvents({
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

    final data = await repo.nearbyEvents(
      latitude: latitude,
      longitude: longitude,
      minDistance: minDistance,
      maxDistance: maxDistance,
    );

    if (isClosed) return;
    maybeEmit(state.copyWith(
      preSelectedEventIndex: 0,
      nearbyEvents: data.take(30).toList(),
      loadingState: LoadingState.done,
      isRefreshLoading: false,
    ));
  }

  Future<void> changeSelectedIndex(int index) async {
    maybeEmit(state.copyWith(
      preSelectedEventIndex: index,
    ));
  }

  @override
  NearbyEventsState? fromJson(Map<String, dynamic> json) {
    return NearbyEventsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NearbyEventsState state) {
    return state.toJson();
  }
}
