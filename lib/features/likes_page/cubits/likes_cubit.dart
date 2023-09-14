import 'dart:async';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/bookmarks_page/models/bookmark_hive_object.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'likes_cubit.freezed.dart';
part 'likes_cubit.g.dart';

@freezed
class LikesState with _$LikesState {
  const factory LikesState({
    required List<String> ids,
    required int count,
    required List<FeaturedEvent> bookmarkEvents,
    required LoadingState loadingState,
  }) = _LikesState;

  factory LikesState.initialize() => const LikesState(
        loadingState: LoadingState.none,
        count: 0,
        ids: [],
        bookmarkEvents: [],
      );

  factory LikesState.fromJson(Map<String, Object?> json) =>
      _$LikesStateFromJson(json);
}

class LikesCubit extends MaybeEmitHydratedCubit<LikesState> {
  final IEventRepo repo;
  final RealmApplicationService applicationService;
  LikesCubit({
    required this.repo,
    required this.applicationService,
  }) : super(LikesState.initialize());

  @override
  LikesState? fromJson(Map<String, dynamic> json) {
    return LikesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LikesState state) {
    return state.toJson();
  }
}
