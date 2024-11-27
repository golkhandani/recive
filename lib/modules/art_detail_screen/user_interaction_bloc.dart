import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_art_repository.dart';
import 'package:art_for_all/core/ioc/i_event_repository.dart';
import 'package:art_for_all/core/ioc/i_news_repository.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/models/artist_abstract_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_interaction_bloc.freezed.dart';
part 'user_interaction_bloc.g.dart';

@freezed
class UserInteractionBlocState with _$UserInteractionBlocState {
  const factory UserInteractionBlocState({
    // id: interaction
    required Map<String, UserInteractionModel> interactions,
  }) = _UserInteractionBlocState;

  factory UserInteractionBlocState.initialize() => const UserInteractionBlocState(
        interactions: {},
      );

  factory UserInteractionBlocState.fromJson(Map<String, Object?> json) =>
      _$UserInteractionBlocStateFromJson(json);
}

class UserInteractionBloc extends HydratedCubit<UserInteractionBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  final IArtRepository artRepository;
  final IEventRepository eventRepository;
  final INewsRepository newsRepository;

  UserInteractionBloc({
    required this.secureStorage,
    required this.sharedStorage,
    required this.artRepository,
    required this.eventRepository,
    required this.newsRepository,
  }) : super(UserInteractionBlocState.initialize());

  Future<void> like(String refId, Entities refType, bool isLiked) async {
    print(refId);
    if (refType != Entities.art) return;

    await artRepository.interact(
      refId,
      Entities.art,
      UserInteracts.like,
      isLiked,
      null,
    );
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
