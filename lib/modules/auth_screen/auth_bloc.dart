import 'package:art_for_all/core/models/user_abstract_model.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/notification_banner_service.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

@freezed
class AuthBlocState with _$AuthBlocState {
  const factory AuthBlocState({
    required bool isLoading,
    String? userId,
    UserAbstractModel? user,
  }) = _AuthBlocState;

  factory AuthBlocState.init() => const AuthBlocState(isLoading: false);
  factory AuthBlocState.fromJson(Map<String, Object?> json) => _$AuthBlocStateFromJson(json);
}

class AuthBloc extends Cubit<AuthBlocState> {
  final IUserService authService;
  final NotificationBannerService bannerService;
  AuthBloc({
    required this.authService,
    required this.bannerService,
  }) : super(AuthBlocState.init());

  getUser() async {
    final user = await authService.getCurrentUser();
    if (!authService.isLoggedIn || user == null) {
      return;
    }

    emit(state.copyWith(user: user));
  }

  resetPassword({
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authService.resetPassword(password: password);
      emit(state.copyWith(
        isLoading: false,
      ));
      onSuccess();
    } on AuthException catch (e) {
      debugPrint(e.toString());
      bannerService.showErrorBanner(e.message.toString());
    } catch (e) {
      onFailure();
      bannerService.showErrorBanner('Something went wrong!');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  resetPasswordRequest({
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      await authService.resetPasswordRequest(email: email);
      emit(state.copyWith(
        isLoading: false,
      ));
      onSuccess();
    } on AuthException catch (e) {
      debugPrint(e.toString());
      bannerService.showErrorBanner("Email is invalid!");
    } catch (e) {
      onFailure();
      bannerService.showErrorBanner('Something went wrong!');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  resetPasswordCode({
    required String email,
    required String code,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authService.resetPasswordCode(
        email: email,
        code: code,
      );
      emit(state.copyWith(
        isLoading: false,
      ));
      onSuccess();
    } on AuthException catch (e) {
      debugPrint(e.toString());
      bannerService.showErrorBanner("Code is expired or invalid!");
    } catch (e) {
      debugPrint(e.toString());
      onFailure();
      bannerService.showErrorBanner('Something went wrong!');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  loginGuest({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await authService.loginGuest();
      emit(state.copyWith(
        isLoading: false,
        userId: res.user.id,
      ));
      onSuccess();
    } on AuthException catch (e) {
      bannerService.showErrorBanner(e.message);
    } catch (e) {
      onFailure();
      bannerService.showErrorBanner('Something went wrong: ${e.toString()}');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  loginWithEmail({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await authService.loginWithEmail(email: email, password: password);
      emit(state.copyWith(
        isLoading: false,
        userId: res.user.id,
      ));
      onSuccess();
    } on AuthException catch (e) {
      bannerService.showErrorBanner(e.message);
    } catch (e) {
      onFailure();
      bannerService.showErrorBanner('Something went wrong: ${e.toString()}');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  loginWithGoogle({
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final res = await authService.loginWithGoogle();
      emit(state.copyWith(
        isLoading: false,
        userId: res.user.id,
      ));
      onSuccess();
    } on AuthException catch (e) {
      bannerService.showErrorBanner(e.message);
    } catch (e) {
      onFailure();
      bannerService.showErrorBanner('Something went wrong: ${e.toString()}');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  registerWithEmail({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final user = await authService.signUpWithEmail(
        email: email,
        password: password,
      );
      emit(state.copyWith(isLoading: false, userId: user.id));
      bannerService.showSuccessBanner('Please check your email inbox!');
      onSuccess();
    } on AuthException catch (e) {
      bannerService.showErrorBanner(e.message);
      onFailure();
    } catch (e) {
      bannerService.showErrorBanner('Something went wrong: ${e.toString()}');
      onFailure();
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  logout() async {
    emit(state.copyWith(isLoading: true));
    await authService.logout();
    emit(state.copyWith(isLoading: false));
  }

  delete() async {
    emit(state.copyWith(isLoading: true));
    await authService.delete();
    emit(state.copyWith(isLoading: false));
  }
}
