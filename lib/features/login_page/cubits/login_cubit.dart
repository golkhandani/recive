import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realm/realm.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/ioc/realm_service.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'login_cubit.freezed.dart';
part 'login_cubit.g.dart';

// client id = 337988051792-uhhb488nd5mu1kdavaa6m7i6o8383vbi.apps.googleusercontent.com
// client secret = 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
// secret => AIzaSyBmaTbzEzC59qeAurCa4jq3Q67j7Q14Zv0

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

  factory LoginState.fromJson(Map<String, Object?> json) =>
      _$LoginStateFromJson(json);
}

class LoginCubit extends MaybeEmitHydratedCubit<LoginState> {
  final FlutterSecureStorage storage;
  final GoogleSignIn googleSignIn;
  final RealmApplicationService applicationService;

  LoginCubit({
    required this.storage,
    required this.googleSignIn,
    required this.applicationService,
  }) : super(LoginState.initialize());

  Future<void> loginWithGoogle({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    try {
      maybeEmit(state.copyWith(
        googleLoginLoadingState: LoadingState.loading,
      ));

      final googleResult = await googleSignIn.signIn();
      final googleKey = await googleResult?.authentication;

      if (googleKey?.idToken != null) {
        final customUserData = {
          'name': googleSignIn.currentUser?.displayName,
          'email': googleSignIn.currentUser?.email,
          'image_url': googleSignIn.currentUser?.photoUrl,
        };

        final googleAuthCodeCredentials =
            Credentials.googleIdToken(googleKey!.idToken!);

        await applicationService.login(googleAuthCodeCredentials);

        await applicationService.app.currentUser?.functions
            .call("writeCustomUserData", [customUserData]);
        await applicationService.app.currentUser?.refreshCustomData();
        onSuccess();
      } else {
        onFailure();
      }
    } catch (e) {
      print(e);
      onFailure();
    } finally {
      maybeEmit(state.copyWith(
        googleLoginLoadingState: LoadingState.done,
      ));
    }
  }

  Future<void> loginWithApple({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    try {
      maybeEmit(state.copyWith(
        appleLoginLoadingState: LoadingState.loading,
      ));
      await Future.delayed(Duration(milliseconds: 300));

      throw Error();
      onSuccess();
    } catch (e) {
      onFailure();
    } finally {
      maybeEmit(state.copyWith(
        appleLoginLoadingState: LoadingState.done,
      ));
    }
  }

  Future<void> logout({required Future<void> Function() onSuccess}) async {
    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.loading,
    ));

    await Future.delayed(Duration(milliseconds: 1000));
    await applicationService.logout();

    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.done,
    ));

    await onSuccess();
  }

  Future<void> deleteAccount({
    required Future<void> Function() onSuccess,
  }) async {
    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.loading,
    ));

    if (applicationService.app.currentUser != null) {
      await applicationService.app
          .deleteUser(applicationService.app.currentUser!);
      await applicationService.logout();
    }

    await Future.delayed(Duration(milliseconds: 1000));

    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.done,
    ));

    await onSuccess();
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
