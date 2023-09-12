import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/favourites_page/models/favourite_storage.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/features/near_me_page/models/event_complete.dart';
import 'package:recive/features/near_me_page/repos/nearby_event_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'near_by_event_detail_cubit.freezed.dart';
part 'near_by_event_detail_cubit.g.dart';

@freezed
class NearbyEventDetailState with _$NearbyEventDetailState {
  const factory NearbyEventDetailState({
    required bool isFavourite,
    required int preSelectedEventIndex,
    required EventComplete? nearbyEvent,
    required LoadingState loadingState,
  }) = _NearbyEventDetailState;

  factory NearbyEventDetailState.initialize() => const NearbyEventDetailState(
        isFavourite: false,
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
  final IEventRepo eventRepo;
  final Box<FavouriteStroage> favouriteBox;
  NearbyEventDetailCubit({
    required this.repo,
    required this.eventRepo,
    required this.favouriteBox,
  }) : super(NearbyEventDetailState.initialize());

  Future<void> loadNearbyEvent(String id) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await eventRepo.completeEventById(id: id);

    if (isClosed) return;
    maybeEmit(state.copyWith(
      nearbyEvent: data,
      loadingState: LoadingState.done,
    ));

    final current = favouriteBox.get(FavouriteStroage.favouriteItemsKey);
    maybeEmit(state.copyWith(
      isFavourite: current?.ids.contains(id) ?? false,
    ));
  }

  Future<void> emptyNearbyEvent() async {
    maybeEmit(NearbyEventDetailState.initialize());
  }

  Future<void> toggleFavorite(String id) async {
    final isFavourite = state.isFavourite;
    maybeEmit(state.copyWith(
      isFavourite: !isFavourite,
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
