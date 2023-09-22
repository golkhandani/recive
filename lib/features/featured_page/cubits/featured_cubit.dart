import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:recive/enums/event_sort.dart';
import 'package:recive/enums/loading_state.dart';
import 'package:recive/features/featured_page/models/art_abstract_model.dart';
import 'package:recive/features/featured_page/models/art_model.dart';
import 'package:recive/features/featured_page/repos/arts_repo.interface.dart';
import 'package:recive/utils/maybe_emit_cubit.dart';

part 'featured_cubit.freezed.dart';
part 'featured_cubit.g.dart';

@freezed
class FeaturedState with _$FeaturedState {
  const factory FeaturedState({
    required ArtAbstractModel? artAbstractItem,
    required ArtModel? artItem,
    required List<ArtAbstractModel> artAbstractItems,
    required List<ArtAbstractModel> artAbstractItemsSpotlight,
    required LoadingState loadingState,
  }) = _FeaturedState;

  factory FeaturedState.initialize() => const FeaturedState(
        artAbstractItem: null,
        artItem: null,
        //
        artAbstractItems: [],
        artAbstractItemsSpotlight: [],
        loadingState: LoadingState.none,
      );

  factory FeaturedState.fromJson(Map<String, Object?> json) =>
      _$FeaturedStateFromJson(json);
}

class FeaturedCubit extends MaybeEmitHydratedCubit<FeaturedState> {
  final IArtRepo repo;
  FeaturedCubit({
    required this.repo,
  }) : super(FeaturedState.initialize());

  Future<void> loadFeatured() async {
    maybeEmit(state.copyWith(
      loadingState: LoadingState.loading,
    ));

    final data = await repo.getFeaturedArts(
      limit: 50,
      sortBy: ArtItemSortBy.idAsc,
    );
    data.shuffle();

    maybeEmit(state.copyWith(
      artAbstractItems: data,
      artAbstractItemsSpotlight: data.take(5).toList(),
      loadingState: LoadingState.done,
    ));
  }

  @override
  FeaturedState? fromJson(Map<String, dynamic> json) {
    return FeaturedState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FeaturedState state) {
    return state.toJson();
  }
}
