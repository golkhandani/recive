part of 'greeting_header_bloc.dart';

@freezed
class GreetingHeaderState with _$GreetingHeaderState {
  const factory GreetingHeaderState({
    @Default(false) bool isCached,
    @Default(true) bool isLoading,
    @Default(0) int notificationCount,
    @Default(null) User? user,
  }) = _GreetingHeaderState;

  const GreetingHeaderState._();

  bool get hasUser => user != null;
  bool get hasNotification => notificationCount > 0;

  factory GreetingHeaderState.fromJson(Map<String, dynamic> json) =>
      _$GreetingHeaderStateFromJson(json);
}
