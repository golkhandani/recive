import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/event_sort.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/featured_page/models/event_complete.dart';
import 'package:recive/features/featured_page/models/featured_event.dart';
import 'package:recive/features/featured_page/repos/event_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'featured_events_cubit.freezed.dart';
part 'featured_events_cubit.g.dart';

@freezed
class FeatureEventsState with _$FeatureEventsState {
  const factory FeatureEventsState({
    required ArtAbstractModel? artAbstractItem,
    required ArtModel? artItem,
    required List<ArtAbstractModel> artAbstractItems,
    required List<ArtAbstractModel> artAbstractItemsSpotlight,
    required LoadingState loadingState,
  }) = _FeatureEventsState;

  factory FeatureEventsState.initialize() => const FeatureEventsState(
        artAbstractItem: null,
        artItem: null,
        //
        artAbstractItems: [],
        artAbstractItemsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory FeatureEventsState.fromJson(Map<String, Object?> json) =>
      _$FeatureEventsStateFromJson(json);
}

class FeatureEventsCubit extends MaybeEmitHydratedCubit<FeatureEventsState> {
  final IEventRepo repo;
  FeatureEventsCubit({
    required this.repo,
  }) : super(FeatureEventsState.initialize());

  Future<void> loadFeaturedEvents() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.featuredEvents(
      limit: 50,
      sortBy: ArtItemSortBy.idAsc,
    );
    data.shuffle();

    maybeEmit(state.copyWith(
      artAbstractItems: data,
      artAbstractItemsSpotlight: data.take(3).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  FeatureEventsState? fromJson(Map<String, dynamic> json) {
    return FeatureEventsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FeatureEventsState state) {
    return state.toJson();
  }
}
