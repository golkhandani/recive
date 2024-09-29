import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'detail_art_bloc.freezed.dart';
part 'detail_art_bloc.g.dart';

@freezed
class DetailArtBlocState with _$DetailArtBlocState {
  const factory DetailArtBlocState({
    required LoadingState isLoadingArt,
    ArtAbstractModel? artAbstract,
    ArtModel? art,
  }) = _DetailArtBlocState;

  factory DetailArtBlocState.initialize() => const DetailArtBlocState(
        isLoadingArt: LoadingState.none,
      );

  factory DetailArtBlocState.fromJson(Map<String, Object?> json) =>
      _$DetailArtBlocStateFromJson(json);
}

class DetailArtBloc extends HydratedCubit<DetailArtBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  final IArtRepository artRepository;

  DetailArtBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.artRepository,
  }) : super(DetailArtBlocState.initialize());

  Future<void> init(String id, ArtAbstractModel? artAbstract) async {
    emit(state.copyWith(
      isLoadingArt: LoadingState.loading,
      artAbstract: artAbstract,
    ));

    final art = await artRepository.getDetailArt(id);

    emit(state.copyWith(
      isLoadingArt: LoadingState.done,
      art: art,
    ));
  }

  @override
  DetailArtBlocState? fromJson(Map<String, dynamic> json) {
    return DetailArtBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DetailArtBlocState state) {
    return state.toJson();
  }
}
