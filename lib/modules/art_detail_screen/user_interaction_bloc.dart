import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_event_repository.dart';
import 'package:art_for_all/core/ioc/i_news_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/ioc/i_user_interaction_repository.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/search_abstract_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_interaction_bloc.freezed.dart';
part 'user_interaction_bloc.g.dart';

@freezed
class UserInteractionBlocState with _$UserInteractionBlocState {
  const factory UserInteractionBlocState({
    // id: interaction
    required Map<String, (EntityType, UserInteractionModel)> interactions,
    required List<InteratedEntityAbstractModel> savedItems,
    required PaginationOffset savedItemsPagination,
  }) = _UserInteractionBlocState;

  factory UserInteractionBlocState.initialize() => const UserInteractionBlocState(
        interactions: {},
        savedItems: [],
        savedItemsPagination: PaginationOffset(limit: 50),
      );

  factory UserInteractionBlocState.fromJson(Map<String, Object?> json) =>
      _$UserInteractionBlocStateFromJson(json);
}

class UserInteractionBloc extends Cubit<UserInteractionBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  final IArtRepository artRepository;
  final IEventRepository eventRepository;
  final INewsRepository newsRepository;
  final IUserInteractionRepository userInteractionRepository;

  UserInteractionBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.artRepository,
    required this.eventRepository,
    required this.newsRepository,
    required this.userInteractionRepository,
  }) : super(UserInteractionBlocState.initialize());

  Future<void> interact(
    String refId,
    EntityType refType,
    UserInteractionModel interaction,
  ) async {
    final res = await userInteractionRepository.interact(refId, refType, interaction);
    if (res == null) return;

    final updated = Map<String, (EntityType, UserInteractionModel)>.from(state.interactions);
    updated[refId] = (refType, res);
    emit(state.copyWith(interactions: updated));
  }

  Future<void> getSavedItems({bool reload = false}) async {
    if (reload) {
      emit(state.copyWith(
        savedItemsPagination: const PaginationOffset(limit: 50),
      ));
    }
    if (state.savedItemsPagination.isDone) {
      return;
    }
    final res = await userInteractionRepository.getSavedItems(
      page: state.savedItemsPagination.page,
      limit: state.savedItemsPagination.limit,
    );

    final isDone = res.length < state.savedItemsPagination.limit;
    emit(state.copyWith(
      savedItems: reload ? res : [...state.savedItems, ...res],
      savedItemsPagination: state.savedItemsPagination.copyWith(
        page: isDone ? state.savedItemsPagination.page : state.savedItemsPagination.page + 1,
        isDone: isDone,
      ),
    ));
  }

  @override
  UserInteractionBlocState? fromJson(Map<String, dynamic> json) {
    return UserInteractionBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserInteractionBlocState state) {
    return state.toJson();
  }
}
