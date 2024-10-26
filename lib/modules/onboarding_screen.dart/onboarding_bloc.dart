import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/models/art_abstract_model.dart';
import 'package:art_for_all/core/models/art_model.dart';
import 'package:art_for_all/core/models/event_abstract_model.dart';
import 'package:art_for_all/core/models/news_abstract_model.dart';
import 'package:art_for_all/environment.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'onboarding_bloc.freezed.dart';
part 'onboarding_bloc.g.dart';

@freezed
class OnboardingBlocState with _$OnboardingBlocState {
  const factory OnboardingBlocState({
    required LoadingState isLoadingArt,
    ArtAbstractModel? artAbstract,
    ArtModel? art,
    required List<NewsAbstractModel> news,
    required List<EventAbstractModel> events,
  }) = _OnboardingBlocState;

  factory OnboardingBlocState.initialize() => const OnboardingBlocState(
        isLoadingArt: LoadingState.none,
        news: [],
        events: [],
      );

  factory OnboardingBlocState.fromJson(Map<String, Object?> json) =>
      _$OnboardingBlocStateFromJson(json);
}

class OnboardingBloc extends HydratedCubit<OnboardingBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;

  OnboardingBloc({
    required this.secureStorage,
    required this.sharedStorage,
  }) : super(OnboardingBlocState.initialize());

  Future<void> done(VoidCallback onSuccess) async {
    await sharedStorage.write(key: Environment.isIntroCheckedKey, value: 'true');
    onSuccess();
  }

  @override
  OnboardingBlocState? fromJson(Map<String, dynamic> json) {
    return OnboardingBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(OnboardingBlocState state) {
    return state.toJson();
  }
}
