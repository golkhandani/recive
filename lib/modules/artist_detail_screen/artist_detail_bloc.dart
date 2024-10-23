import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_artist_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'artist_detail_bloc.freezed.dart';
part 'artist_detail_bloc.g.dart';

@freezed
class ArtistDetailBlocState with _$ArtistDetailBlocState {
  const factory ArtistDetailBlocState({
    required LoadingState isLoading,
    ArtistAbstractModel? artistAbstract,
    ArtistModel? artist,
  }) = _ArtistDetailBlocState;

  factory ArtistDetailBlocState.initialize() => const ArtistDetailBlocState(
        isLoading: LoadingState.none,
      );

  factory ArtistDetailBlocState.fromJson(Map<String, Object?> json) =>
      _$ArtistDetailBlocStateFromJson(json);
}

class ArtistDetailBloc extends HydratedCubit<ArtistDetailBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;

  final IArtistRepository artistRepository;

  ArtistDetailBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.artistRepository,
  }) : super(ArtistDetailBlocState.initialize());

  Future<void> init(String id) async {
    emit(state.copyWith(
      isLoading: LoadingState.loading,
    ));

    final artist = await artistRepository.getArtistById(id);

    emit(state.copyWith(
      isLoading: LoadingState.loading,
      artist: artist,
    ));

    emit(state.copyWith(
      isLoading: LoadingState.done,
    ));
  }

  @override
  ArtistDetailBlocState? fromJson(Map<String, dynamic> json) {
    return ArtistDetailBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ArtistDetailBlocState state) {
    return state.toJson();
  }
}
