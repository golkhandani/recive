import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_community_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/community_abstract_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'community_detail_bloc.freezed.dart';
part 'community_detail_bloc.g.dart';

@freezed
class CommunityDetailBlocState with _$CommunityDetailBlocState {
  const factory CommunityDetailBlocState({
    required LoadingState isLoading,
    CommunityAbstractModel? communityAbstract,
    CommunityModel? community,
  }) = _CommunityDetailBlocState;

  factory CommunityDetailBlocState.initialize() => const CommunityDetailBlocState(
        isLoading: LoadingState.none,
      );

  factory CommunityDetailBlocState.fromJson(Map<String, Object?> json) =>
      _$CommunityDetailBlocStateFromJson(json);
}

class CommunityDetailBloc extends HydratedCubit<CommunityDetailBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;

  final ICommunityRepository communityRepository;

  CommunityDetailBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.communityRepository,
  }) : super(CommunityDetailBlocState.initialize());

  Future<void> init(String id) async {
    emit(state.copyWith(
      isLoading: LoadingState.loading,
    ));

    final community = await communityRepository.getCommunityById(id);

    emit(state.copyWith(
      isLoading: LoadingState.loading,
      community: community,
    ));

    emit(state.copyWith(
      isLoading: LoadingState.done,
    ));
  }

  @override
  CommunityDetailBlocState? fromJson(Map<String, dynamic> json) {
    return CommunityDetailBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CommunityDetailBlocState state) {
    return state.toJson();
  }
}
