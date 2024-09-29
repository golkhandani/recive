import 'package:art_for_all/core/models/user_abstract_model.dart';
import 'package:art_for_all/core/services/auth_service.dart';
import 'package:art_for_all/core/services/notification_banner_service.dart';
import 'package:art_for_all/utils/transformable_cubit.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_bloc.freezed.dart';
part 'profile_bloc.g.dart';

@freezed
class ProfileBlocState with _$ProfileBlocState {
  const factory ProfileBlocState({
    required bool isLoading,
    required bool isLoadingImage,
    String? userId,
    UserAbstractModel? user,
  }) = _ProfileBlocState;

  factory ProfileBlocState.init() => const ProfileBlocState(
        isLoading: false,
        isLoadingImage: false,
      );
  factory ProfileBlocState.fromJson(Map<String, Object?> json) =>
      _$ProfileBlocStateFromJson(json);
}

class ProfileBloc extends HydratedTransformableCubit<ProfileBlocState> {
  final IUserService userService;
  final NotificationBannerService bannerService;
  ProfileBloc({
    required this.userService,
    required this.bannerService,
  }) : super(ProfileBlocState.init());

  getUser() async {
    final user = await userService.getCurrentUser();
    if (!userService.isLoggedIn || user == null) {
      return;
    }

    emit(state.copyWith(user: user));
  }

  updateName(String name) async {
    withDebounce(() async {
      emit(state.copyWith(
        user: state.user?.copyWith(
          name: name,
        ),
      ));

      await userService.updateUser(name: name);
    });
  }

  uploadAvatar(String path) async {
    emit(state.copyWith(
      isLoadingImage: true,
      user: state.user?.copyWith(
        imageUrl: '',
      ),
    ));
    final uploaded = await userService.uploadAvatar(path);
    emit(
      state.copyWith(
        isLoadingImage: false,
        user: state.user?.copyWith(
          imageUrl: uploaded,
        ),
      ),
    );
  }

  @override
  ProfileBlocState? fromJson(Map<String, dynamic> json) {
    return ProfileBlocState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProfileBlocState state) {
    return state.toJson();
  }
}
