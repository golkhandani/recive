part of 'greeting_header_bloc.dart';

@freezed
class GreetingHeaderEvent with _$GreetingHeaderEvent {
  const factory GreetingHeaderEvent.load() = _GreetingHeaderEventLoad;
}
