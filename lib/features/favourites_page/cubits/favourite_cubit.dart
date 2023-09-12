import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/favourites_page/models/favourite_storage.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'favourite_cubit.freezed.dart';
part 'favourite_cubit.g.dart';

@freezed
class FavouritesState with _$FavouritesState {
  static const favouriteStateKey = 'favouriteStateKey';
  const factory FavouritesState({
    required List<String> ids,
    required int count,
    required List<FeaturedEvent> favouriteEvents,
    required LoadingState loadingState,
  }) = _FavouritesState;

  factory FavouritesState.initialize() => const FavouritesState(
        loadingState: LoadingState.none,
        count: 0,
        ids: [],
        favouriteEvents: [],
      );

  factory FavouritesState.fromJson(Map<String, Object?> json) =>
      _$FavouritesStateFromJson(json);
}

class FavouritesCubit extends MaybeEmitHydratedCubit<FavouritesState> {
  final IEventRepo repo;
  final Box<FavouriteStroage> favouriteBox;
  final RealmApplicationService applicationService;
  FavouritesCubit({
    required this.repo,
    required this.favouriteBox,
    required this.applicationService,
  }) : super(FavouritesState.initialize());

  Future<void> loadFavourites() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    final userFavourites =
        applicationService.currentUserCustomData?.favouriteEvent ?? [];
    final current = favouriteBox.get(FavouriteStroage.favouriteItemsKey);

    if (userFavourites.length != current?.ids.length) {
      // update local box
      await favouriteBox.put(
        FavouriteStroage.favouriteItemsKey,
        FavouriteStroage(
          ids: userFavourites,
          count: userFavourites.length,
        ),
      );
    }
    maybeEmit(
      state.copyWith(
        loadingState: LoadingState.done,
        ids: current?.ids ?? [],
        count: current?.count ?? 0,
      ),
    );

    final data = await repo.favouriteEvents(limit: 10, ids: current?.ids ?? []);
    maybeEmit(
      state.copyWith(
        favouriteEvents: data,
      ),
    );
  }

  Future<void> toggleFavorite(String id) async {
    final current = favouriteBox.get(FavouriteStroage.favouriteItemsKey);
    var ids = List<String>.from(current?.ids ?? []);
    final isFavourite = ids.contains(id);

    if (!isFavourite) {
      ids.add(id);
    } else {
      ids.remove(id);
    }
    ids = ids.toSet().toList();

    await favouriteBox.put(
      FavouriteStroage.favouriteItemsKey,
      FavouriteStroage(
        ids: ids,
        count: ids.length,
      ),
    );
    await applicationService.updateFavouriteEventIds(ids);

    final updated = favouriteBox.get(FavouriteStroage.favouriteItemsKey);
    final updatedIds = updated?.ids ?? [];
    maybeEmit(state.copyWith(
      loadingState: LoadingState.done,
      ids: updatedIds,
      count: updatedIds.length,
    ));
  }

  @override
  FavouritesState? fromJson(Map<String, dynamic> json) {
    return FavouritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavouritesState state) {
    return state.toJson();
  }
}
