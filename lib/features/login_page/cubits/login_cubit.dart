import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recive/features/categories_page/models/category.dart';
import 'package:recive/layout/context_ui_extension.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  factory LoginState.fromJson(Map<String, Object?> json) =>
      _$LoginStateFromJson(json);
}

class LoginCubit extends MaybeEmitHydratedCubit<LoginState> {
  static const isLoggedInKey = 'isLoggedInKey';
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';
  final FlutterSecureStorage storage;

  LoginCubit({
    required this.storage,
  }) : super(LoginState.initialize());

  Future<void> loginWithGoogle({required VoidCallback onSuccess}) async {
    maybeEmit(state.copyWith(
      googleLoginLoadingState: LoadingState.loading,
    ));
    // String appId = "suggesteventpath-mgnsw";
    // final appConfig = AppConfiguration(appId);
    // final app = App(appConfig);
    // final user = await app.logIn(Credentials.anonymous());
    // print(user);

    await Future.delayed(Duration(milliseconds: 1000));
    await storage.write(key: refreshTokenKey, value: refreshTokenKey);
    await storage.write(
      key: accessTokenKey,
      value: '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
    );
    await storage.write(key: isLoggedInKey, value: true.toString());

    maybeEmit(state.copyWith(
      googleLoginLoadingState: LoadingState.done,
    ));
    onSuccess();
  }

  Future<void> loginWithApple({required VoidCallback onSuccess}) async {
    maybeEmit(state.copyWith(
      appleLoginLoadingState: LoadingState.loading,
    ));
    await Future.delayed(Duration(milliseconds: 1000));
    await storage.write(key: refreshTokenKey, value: refreshTokenKey);
    await storage.write(
      key: accessTokenKey,
      value: '3nbNFOHUaGZqpdCYpXquczSG21iRaB80gPlZhRiWfnaTfJXUH9dDOjwYRzuk65mH',
    );
    await storage.write(key: isLoggedInKey, value: true.toString());
    maybeEmit(state.copyWith(
      appleLoginLoadingState: LoadingState.done,
    ));
    onSuccess();
  }

  Future<void> logout({required VoidCallback onSuccess}) async {
    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.loading,
    ));

    await Future.delayed(Duration(milliseconds: 1000));
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: isLoggedInKey);
    maybeEmit(state.copyWith(
      logoutLoadingState: LoadingState.done,
    ));

    onSuccess();
  }

  Future<void> checkLogin({
    required VoidCallback onLogin,
    required VoidCallback onNeedLogin,
  }) async {
    await Future.delayed(Duration(milliseconds: 1000));
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);
    final isLoggedIn = await storage.read(key: isLoggedInKey);

    print('${refreshToken} - ${accessToken} - ${isLoggedIn}');

    if (refreshToken == null ||
        accessToken == null ||
        isLoggedIn == null ||
        isLoggedIn == 'false') {
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
