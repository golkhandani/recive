// To parse this JSON data, do
//
//     final fasting = fastingFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fasting.model.freezed.dart';
part 'fasting.model.g.dart';

@freezed
class Fasting with _$Fasting {
  const factory Fasting({
    required String title,
    required String description,
    required int fastingWindowDuration,
    required int fastingWindowStart,
    required int eatingWindowDuration,
    required List<FastingHour> fastingHours,
  }) = _Fasting;

  factory Fasting.fromJson(Map<String, dynamic> json) =>
      _$FastingFromJson(json);
}

@freezed
class FastingHour with _$FastingHour {
  const factory FastingHour({
    required int start,
    required int end,
    required String description,
    required String colorHex,
  }) = _FastingHour;

  factory FastingHour.fromJson(Map<String, dynamic> json) =>
      _$FastingHourFromJson(json);
}

@freezed
class FastingTimer with _$FastingTimer {
  const factory FastingTimer({
    required int hours,
    required int minutes,
    required int seconds,
  }) = _FastingTimer;

  const FastingTimer._();
  factory FastingTimer.fromJson(Map<String, dynamic> json) =>
      _$FastingTimerFromJson(json);

  String get displayClock =>
      '${hours > 9 ? hours : '0$hours'}:${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}';
}
