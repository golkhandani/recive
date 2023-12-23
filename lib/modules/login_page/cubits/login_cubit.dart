import 'package:flutter/foundation.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import 'package:recive/core/enums/loading_state.dart';
import 'package:recive/modules/bookmarks_page/models/bookmark_hive_object.dart';
import 'package:recive/modules/profile/models/user_custom_data.dart';
import 'package:recive/shared/extensions/text_style_extension.dart';
import 'package:recive/shared/ioc/locator.dart';
import 'package:recive/shared/services/realm_service.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

part 'login_cubit.freezed.dart';
part 'login_cubit.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required bool isLoggedIn,
    required LoadingState googleLoginLoadingState,
    required LoadingState appleLoginLoadingState,
    required LoadingState logoutLoadingState,
  }) = _LoginState;

  factory LoginState.initialize() => const LoginState(
        isLoggedIn: false,
        googleLoginLoadingState: LoadingState.none,
        appleLoginLoadingState: LoadingState.none,
        logoutLoadingState: LoadingState.none,
      );

  factory LoginState.fromJson(Map<String, Object?> json) => _$LoginStateFromJson(json);
}

class LoginCubit extends MaybeEmitHydratedCubit<LoginState> {
  final FlutterSecureStorage storage;
  final GoogleSignIn googleSignIn;
  final RealmApplicationService applicationService;
  final Box<AppPaletteType> themeBox;
  final Box<bool> introBox;
  final Box<BookmarkHiveObject> bookmarkBox;

  LoginCubit({
    required this.storage,
    required this.googleSignIn,
    required this.applicationService,
    required this.themeBox,
    required this.introBox,
    required this.bookmarkBox,
  }) : super(LoginState.initialize());

  Future<void> loginWithGoogle({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    try {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
        appleLoginLoadingState: LoadingState.none,
        googleLoginLoadingState: LoadingState.loading,
      ));

      final googleResult = await googleSignIn.signIn();
      final googleKey = await googleResult?.authentication;

      if (googleKey?.idToken != null) {
        final customUserData = UserCustomData(
          name: googleSignIn.currentUser?.displayName,
          email: googleSignIn.currentUser?.email,
          imageUrl: googleSignIn.currentUser?.photoUrl,
          bookmarkArts: [],
        );
        await applicationService.loginWithGoogleId(
          googleKey!.idToken!,
          data: customUserData,
        );
        await _loadUserData();
        onSuccess();
      } else {
        onFailure();
      }
    } catch (e) {
      locator.logger.e('loginWithGoogle error:', error: e);
      onFailure();
    } finally {
      maybeEmit(state.copyWith(
        googleLoginLoadingState: LoadingState.done,
      ));
    }
  }

  Future<void> loginWithApiKey({
    required void Function() onSuccess,
    required void Function() onFailure,
  }) async {
    try {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
        appleLoginLoadingState: LoadingState.none,
        googleLoginLoadingState: LoadingState.none,
      ));

      await applicationService.loginWithApiKey();
      await _loadUserData();
      onSuccess();
    } catch (e) {
      locator.logger.e('loginWithApiKey error:', error: e);
      onFailure();
    }
  }

  Future<void> _loadUserData() async {
    final favIds = await applicationService.getFavouriteArtIds();
    final data = {
      for (var e in favIds)
        e: BookmarkHiveObject(
          id: e,
          dateTime: DateTime.now(),
        )
    };
    await bookmarkBox.putAll(data);
    return;
  }

  Future<void> loginWithApple({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    try {
      maybeEmit(state.copyWith(
        appleLoginLoadingState: LoadingState.loading,
      ));
      await Future.delayed(const Duration(milliseconds: 300));

      throw Error();
      // onSuccess();
    } catch (e) {
      onFailure();
    } finally {
      maybeEmit(state.copyWith(
        appleLoginLoadingState: LoadingState.done,
      ));
    }
  }

  Future<void> logout({required Future<void> Function() onSuccess}) async {
    try {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.loading,
      ));

      await themeBox.flush();
      await introBox.flush();
      await bookmarkBox.flush();
      await themeBox.clear();
      await introBox.clear();
      await bookmarkBox.clear();

      await applicationService.logout();

      await Future.delayed(const Duration(milliseconds: 1000));

      await onSuccess();
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
      ));
    } finally {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
      ));
    }
  }

  Future<void> deleteAccount({
    required Future<void> Function() onSuccess,
  }) async {
    try {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.loading,
      ));
      await themeBox.flush();
      await introBox.flush();
      await bookmarkBox.flush();

      await themeBox.clear();
      await introBox.clear();
      await bookmarkBox.clear();

      if (applicationService.currentUser != null) {
        await applicationService.delete();
        await applicationService.logout();
      }

      await Future.delayed(const Duration(milliseconds: 1000));

      await onSuccess();
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
      ));
    } finally {
      maybeEmit(state.copyWith(
        logoutLoadingState: LoadingState.none,
      ));
    }
  }

  Future<void> checkLogin({
    required VoidCallback onLogin,
    required VoidCallback onNeedLogin,
  }) async {
    final isLoggedIn = await applicationService.checkLogin();

    if (!isLoggedIn) {
      return onNeedLogin();
    }
    return onLogin();
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    return LoginState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return state.toJson();
  }
}
