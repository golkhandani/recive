import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/bookmarks_page/models/favourite_storage.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'bookmarks_cubit.freezed.dart';
part 'bookmarks_cubit.g.dart';

@freezed
class BookmarksState with _$BookmarksState {
  static const favouriteStateKey = 'favouriteStateKey';
  const factory BookmarksState({
    required List<String> ids,
    required int count,
    required List<FeaturedEvent> bookmarkEvents,
    required LoadingState loadingState,
  }) = _BookmarksState;

  factory BookmarksState.initialize() => const BookmarksState(
        loadingState: LoadingState.none,
        count: 0,
        ids: [],
        bookmarkEvents: [],
      );

  factory BookmarksState.fromJson(Map<String, Object?> json) =>
      _$BookmarksStateFromJson(json);
}

class BookmarksCubit extends MaybeEmitHydratedCubit<BookmarksState> {
  final IEventRepo repo;
  final Box<BookmarkStore> bookmarkBox;
  final RealmApplicationService applicationService;
  BookmarksCubit({
    required this.repo,
    required this.bookmarkBox,
    required this.applicationService,
  }) : super(BookmarksState.initialize());

  Future<void> loadBookmarks() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));
    final userFavourites =
        applicationService.currentUserCustomData?.bookmarkEvents ?? [];
    final current = bookmarkBox.get(BookmarkStore.keyName);

    if (userFavourites.length != current?.ids.length) {
      // update local box
      await bookmarkBox.put(
        BookmarkStore.keyName,
        BookmarkStore(
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

    final data = await repo.bookmarkEvents(limit: 10, ids: current?.ids ?? []);
    maybeEmit(
      state.copyWith(
        bookmarkEvents: data,
      ),
    );
  }

  Future<void> toggleFavorite(String id) async {
    final current = bookmarkBox.get(BookmarkStore.keyName);
    var ids = List<String>.from(current?.ids ?? []);
    final isFavourite = ids.contains(id);

    if (!isFavourite) {
      ids.add(id);
    } else {
      ids.remove(id);
    }
    ids = ids.toSet().toList();

    await bookmarkBox.put(
      BookmarkStore.keyName,
      BookmarkStore(
        ids: ids,
        count: ids.length,
      ),
    );
    await applicationService.updateFavouriteEventIds(ids);

    final updated = bookmarkBox.get(BookmarkStore.keyName);
    final updatedIds = updated?.ids ?? [];
    maybeEmit(state.copyWith(
      loadingState: LoadingState.done,
      ids: updatedIds,
      count: updatedIds.length,
    ));
  }

  @override
  BookmarksState? fromJson(Map<String, dynamic> json) {
    return BookmarksState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BookmarksState state) {
    return state.toJson();
  }
}
