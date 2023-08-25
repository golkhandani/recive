import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/nearby_event.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'near_by_events_cubit.freezed.dart';
part 'near_by_events_cubit.g.dart';

@freezed
class NearbyEventsState with _$NearbyEventsState {
  const factory NearbyEventsState({
    required int preSelectedEventIndex,
    required List<NearbyEvent> nearbyEvents,
    required LoadingState loadingState,
  }) = _NearbyEventsState;

  factory NearbyEventsState.initialize() => const NearbyEventsState(
        preSelectedEventIndex: 0,
        nearbyEvents: [],
        loadingState: LoadingState.none,
      );

  factory NearbyEventsState.fromJson(Map<String, Object?> json) =>
      _$NearbyEventsStateFromJson(json);
}

class NearbyEventsCubit extends MaybeEmitHydratedCubit<NearbyEventsState> {
  final IEventRepo repo;
  NearbyEventsCubit({
    required this.repo,
  }) : super(NearbyEventsState.initialize());

  Future<void> loadNearbyEvents() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.nearbyEvents(
      limit: 10,
      city: 'Vancouver',
    );

    if (isClosed) return;
    maybeEmit(state.copyWith(
      nearbyEvents: data,
      loadingState: LoadingState.done,
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
