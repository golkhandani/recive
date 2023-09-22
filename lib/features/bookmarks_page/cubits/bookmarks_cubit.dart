import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/bookmarks_page/models/bookmark_hive_object.dart';
import 'package:recive/features/featured_page/models/art_abstract_model.dart';
import 'package:recive/features/featured_page/repos/arts_repo.interface.dart';
import 'package:recive/ioc/locator.dart';
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
    required List<ArtAbstractModel> bookmarkArts,
    required LoadingState loadingState,
  }) = _BookmarksState;

  factory BookmarksState.initialize() => const BookmarksState(
        loadingState: LoadingState.none,
        count: 0,
        ids: [],
        bookmarkArts: [],
      );

  factory BookmarksState.fromJson(Map<String, Object?> json) =>
      _$BookmarksStateFromJson(json);
}

class BookmarksCubit extends MaybeEmitHydratedCubit<BookmarksState> {
  final IArtRepo repo;
  final Box<BookmarkHiveObject> bookmarkBox;
  final RealmApplicationService applicationService;
  BookmarksCubit({
    required this.repo,
    required this.bookmarkBox,
    required this.applicationService,
  }) : super(BookmarksState.initialize()) {
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final objects = bookmarkBox.values.toList();

    final cIds = objects
        .sorted((a, b) => a.dateTime.isBefore(b.dateTime) ? 1 : 0)
        .map((e) => e.id)
        .toList();
    maybeEmit(
      state.copyWith(
        loadingState: LoadingState.done,
        ids: cIds,
        count: objects.length,
      ),
    );

    final data = await repo.getBookmarkArts(limit: 10, ids: cIds);
    maybeEmit(
      state.copyWith(
        bookmarkArts: cIds
            .map(
              (e) => data.firstWhere((d) => d.id == e),
            )
            .toList(),
      ),
    );
  }

  Future<void> toggleFavorite(
    String id, {
    required VoidCallback onFailure,
  }) async {
    try {
      final objects = bookmarkBox.values;
      var ids = List<String>.from(objects.map((e) => e.id));
      final isBookmarked = bookmarkBox.get(id) != null;

      if (!isBookmarked) {
        ids.add(id);
        await bookmarkBox.put(
          id,
          BookmarkHiveObject(
            id: id,
            dateTime: DateTime.now(),
          ),
        );
      } else {
        ids.remove(id);
        await bookmarkBox.delete(id);
      }
      ids = ids.toSet().toList();

      await applicationService.updateFavouriteArtIds(ids);

      maybeEmit(state.copyWith(
        loadingState: LoadingState.done,
        ids: ids,
        count: ids.length,
      ));
    } catch (e) {
      locator.logger.e("Bookmark failed: ", error: e);
      onFailure();
    }
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
