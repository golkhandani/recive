import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:recive/models/user.model.dart';
import 'package:recive/repositories/user.repository.interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'greeting_header_event.dart';
part 'greeting_header_state.dart';
part 'greeting_header_bloc.freezed.dart';
part 'greeting_header_bloc.g.dart';

class GreetingHeaderBloc
    extends HydratedBloc<GreetingHeaderEvent, GreetingHeaderState> {
  late final isCached = HydratedBloc.storage.read(storageToken) != null;
  @override
  GreetingHeaderState? fromJson(Map<String, dynamic> json) =>
      GreetingHeaderState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(GreetingHeaderState state) => state.toJson();

  final IUserRepository _userRepository;
  GreetingHeaderBloc({
    required IUserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const GreetingHeaderState()) {
    on<GreetingHeaderEvent>((event, emit) async {
      await event.when(load: () => _load(emit));
    });
  }

  Future<void> _load(Emitter<GreetingHeaderState> emit) async {
    if (isCached) {
      return;
    }

    final futures = await Future.value([
      await _userRepository.fetchUserProfile(),
      await _userRepository.fetchUserNotificationCount()
    ]);

    // print("_load futures ${futures}");
    emit(
      state.copyWith(
        isCached: true,
        isLoading: false,
        user: futures[0] as User?,
        notificationCount: futures[1] as int,
      ),
    );
    hydrate();
    return;
  }
}
