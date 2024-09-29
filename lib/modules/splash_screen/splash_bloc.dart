import 'package:art_for_all/core/enums/loading_state.dart';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'splash_bloc.freezed.dart';
part 'splash_bloc.g.dart';

@freezed
class SplashBlocState with _$SplashBlocState {
  static const isIntroViewedKey = 'introductionScreenIsViewed';

  const factory SplashBlocState({
    required bool isLoggedIn,
    required bool isIntroViewed,
    required LoadingState loadingState,
  }) = _SplashBlocState;

  factory SplashBlocState.initialize() => const SplashBlocState(
        isLoggedIn: false,
        isIntroViewed: false,
        loadingState: LoadingState.none,
      );

  factory SplashBlocState.fromJson(Map<String, Object?> json) =>
      _$SplashBlocStateFromJson(json);
}

class SplashBloc extends HydratedCubit<SplashBlocState> {
  final ISecureStorage secureStorage;
  final ISharedStorage sharedPreferences;
  final IUserService userService;

  SplashBloc({
    required this.secureStorage,
    required this.sharedPreferences,
    required this.userService,
  }) : super(SplashBlocState.initialize());

  Future<void> loadSetting() async {
    // final isLoggedIn = await applicationService.checkLogin();
    // final isIntroViewed = introductionBox.get(
    //   SettingLoaderState.isIntroViewedKey,
    //   defaultValue: false,
    // )!;
    // emit(state.copyWith(
    //   isLoggedIn: isLoggedIn,
    //   isIntroViewed: isIntroViewed,
    // ));
  }

  Future<void> doneIntro() async {
    // introductionBox.put(
    //   SettingLoaderState.isIntroViewedKey,
    //   true,
    // );
  }

  Future<void> switchIntroSetting(bool value) async {
    // final current = introductionBox.get(
    //   SettingLoaderState.isIntroViewedKey,
    // );

    // final updatedValue = current == null ? value : !current;

    // introductionBox.put(SettingLoaderState.isIntroViewedKey, updatedValue);
    // emit(state.copyWith(
    //   isIntroViewed: updatedValue,
    // ));
  }

  Future<void> checkInitialization({
    required void Function(int) onIntro,
    required VoidCallback onLoggedIn,
    required VoidCallback onNeedLogin,
  }) async {
    // if (state.loadingState == LoadingState.loading) {
    //   return;
    // }
    // emit(state.copyWith(loadingState: LoadingState.loading));
    final isLoggedIn = userService.isLoggedIn;

    if (!isLoggedIn) {
      emit(state.copyWith(loadingState: LoadingState.done));
      return onNeedLogin();
    }

    // final introIsViewed = introductionBox.get(
    //   SettingLoaderState.isIntroViewedKey,
    //   defaultValue: false,
    // )!;

    // if (!introIsViewed) {
    //   maybeEmit(state.copyWith(loadingState: LoadingState.done));
    //   return onIntro(0);
    // }

    // final locationPermission = await locationService.getPermissionSetting();
    // if (!locationPermission.isPermitted) {
    //   emit(state.copyWith(loadingState: LoadingState.done));
    //   switchIntroSetting(false);
    //   return onIntro(3);
    // }

    emit(state.copyWith(loadingState: LoadingState.done));
    return onLoggedIn();
  }

  @override
  SplashBlocState? fromJson(Map<String, dynamic> json) {
    return SplashBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SplashBlocState state) {
    return state.toJson();
  }
}
