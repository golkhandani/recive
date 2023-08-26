import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/layout/context_ui_extension.dart';

part 'near_by_event_detail_cubit.freezed.dart';
part 'near_by_event_detail_cubit.g.dart';

@freezed
class NearbyEventDetailState with _$NearbyEventDetailState {
  const factory NearbyEventDetailState({
    required int preSelectedEventIndex,
    required EventComplete? nearbyEvent,
    required LoadingState loadingState,
  }) = _NearbyEventDetailState;

  factory NearbyEventDetailState.initialize() => const NearbyEventDetailState(
        preSelectedEventIndex: 0,
        nearbyEvent: null,
        loadingState: LoadingState.none,
      );

  factory NearbyEventDetailState.fromJson(Map<String, Object?> json) =>
      _$NearbyEventDetailStateFromJson(json);
}

class NearbyEventDetailCubit
    extends MaybeEmitHydratedCubit<NearbyEventDetailState> {
  final INearbyEventRepo repo;
  NearbyEventDetailCubit({
    required this.repo,
  }) : super(NearbyEventDetailState.initialize());

  Future<void> loadNearbyEvent(String id) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.event(id: id);

    if (isClosed) return;
    maybeEmit(state.copyWith(
      nearbyEvent: data,
      loadingState: LoadingState.done,
    ));
  }

  Future<void> emptyNearbyEvent() async {
    maybeEmit(state.copyWith(
      nearbyEvent: null,
      loadingState: LoadingState.done,
    ));
  }

  @override
  NearbyEventDetailState? fromJson(Map<String, dynamic> json) {
    return NearbyEventDetailState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NearbyEventDetailState state) {
    return state.toJson();
  }
}
