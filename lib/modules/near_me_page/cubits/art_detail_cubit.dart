import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/bookmarks/models/bookmark_hive_object.dart';
import 'package:recive/modules/featured_page/models/art_model.dart';
import 'package:recive/modules/featured_page/repos/arts_repo.interface.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

part 'art_detail_cubit.freezed.dart';
part 'art_detail_cubit.g.dart';

@freezed
class ArtDetailState with _$ArtDetailState {
  const factory ArtDetailState({
    required bool isBookmarked,
    required int preSelectedIndex,
    required ArtModel? nearbyItem,
    required LoadingState loadingState,
  }) = _ArtDetailState;

  factory ArtDetailState.initialize() => const ArtDetailState(
        isBookmarked: false,
        preSelectedIndex: 0,
        nearbyItem: null,
        loadingState: LoadingState.none,
      );

  factory ArtDetailState.fromJson(Map<String, Object?> json) => _$ArtDetailStateFromJson(json);
}

class ArtDetailCubit extends MaybeEmitHydratedCubit<ArtDetailState> {
  final IArtRepo repo;
  final Box<BookmarkHiveObject> bookmarkBox;
  ArtDetailCubit({
    required this.repo,
    required this.bookmarkBox,
  }) : super(ArtDetailState.initialize());

  Future<void> loadArtById(String id) async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.getArtById(id: id);

    if (isClosed) return;
    maybeEmit(state.copyWith(
      nearbyItem: data,
      loadingState: LoadingState.done,
    ));

    final isBookmarked = bookmarkBox.get(id) != null;
    maybeEmit(state.copyWith(
      isBookmarked: isBookmarked,
    ));
  }

  Future<void> flush() async {
    maybeEmit(ArtDetailState.initialize());
  }

  Future<void> toggleFavorite(String id) async {
    final isBookmarked = state.isBookmarked;
    maybeEmit(state.copyWith(
      isBookmarked: !isBookmarked,
      loadingState: LoadingState.done,
    ));
  }

  @override
  ArtDetailState? fromJson(Map<String, dynamic> json) {
    return ArtDetailState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ArtDetailState state) {
    return state.toJson();
  }
}
