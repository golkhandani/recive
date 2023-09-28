import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/shared/services/realm_service.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

part 'setting_loader_cubit.freezed.dart';
part 'setting_loader_cubit.g.dart';

@freezed
class SettingLoaderState with _$SettingLoaderState {
  static const isIntroViewedKey = 'introductionScreenIsViewed';

  const factory SettingLoaderState({
    required bool isLoggedIn,
    required bool isIntroViewed,
    required LoadingState loadingState,
  }) = _SettingLoaderState;

  factory SettingLoaderState.initialize() => const SettingLoaderState(
        isLoggedIn: false,
        isIntroViewed: false,
        loadingState: LoadingState.none,
      );

  factory SettingLoaderState.fromJson(Map<String, Object?> json) =>
      _$SettingLoaderStateFromJson(json);
}

class SettingLoaderCubit extends MaybeEmitHydratedCubit<SettingLoaderState> {
  final FlutterSecureStorage storage;
  final RealmApplicationService applicationService;
  final Box<bool> introductionBox;

  SettingLoaderCubit({
    required this.storage,
    required this.applicationService,
    required this.introductionBox,
  }) : super(SettingLoaderState.initialize());

  Future<void> loadSetting() async {
    final isLoggedIn = await applicationService.checkLogin();
    final isIntroViewed = introductionBox.get(
      SettingLoaderState.isIntroViewedKey,
      defaultValue: false,
    )!;
    emit(state.copyWith(
      isLoggedIn: isLoggedIn,
      isIntroViewed: isIntroViewed,
    ));
  }

  Future<void> doneIntro() async {
    introductionBox.put(
      SettingLoaderState.isIntroViewedKey,
      true,
    );
  }

  Future<void> switchIntroSetting(bool value) async {
    final current = introductionBox.get(
      SettingLoaderState.isIntroViewedKey,
    );

    final updatedValue = current == null ? value : !current;

    introductionBox.put(SettingLoaderState.isIntroViewedKey, updatedValue);
    emit(state.copyWith(
      isIntroViewed: updatedValue,
    ));
  }

  Future<void> checkInitialization({
    required VoidCallback onIntro,
    required VoidCallback onLoggedin,
    required VoidCallback onNeedLogin,
  }) async {
    final isLoggedIn = await applicationService.checkLogin();

    if (!isLoggedIn) {
      return onNeedLogin();
    }

    final introIsViewed = introductionBox.get(
      SettingLoaderState.isIntroViewedKey,
      defaultValue: false,
    )!;

    if (!introIsViewed) {
      return onIntro();
    }

    return onLoggedin();
  }

  @override
  SettingLoaderState? fromJson(Map<String, dynamic> json) {
    return SettingLoaderState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingLoaderState state) {
    return state.toJson();
  }
}
