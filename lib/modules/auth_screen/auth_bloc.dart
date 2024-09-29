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
