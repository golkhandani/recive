// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fasting.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Fasting _$FastingFromJson(Map<String, dynamic> json) {
  return _Fasting.fromJson(json);
}

/// @nodoc
mixin _$Fasting {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get fastingWindowDuration => throw _privateConstructorUsedError;
  int get fastingWindowStart => throw _privateConstructorUsedError;
  int get eatingWindowDuration => throw _privateConstructorUsedError;
  List<FastingHour> get fastingHours => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FastingCopyWith<Fasting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingCopyWith<$Res> {
  factory $FastingCopyWith(Fasting value, $Res Function(Fasting) then) =
      _$FastingCopyWithImpl<$Res, Fasting>;
  @useResult
  $Res call(
      {String title,
      String description,
      int fastingWindowDuration,
      int fastingWindowStart,
      int eatingWindowDuration,
      List<FastingHour> fastingHours});
}

/// @nodoc
class _$FastingCopyWithImpl<$Res, $Val extends Fasting>
    implements $FastingCopyWith<$Res> {
  _$FastingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? fastingWindowDuration = null,
    Object? fastingWindowStart = null,
    Object? eatingWindowDuration = null,
    Object? fastingHours = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      fastingWindowDuration: null == fastingWindowDuration
          ? _value.fastingWindowDuration
          : fastingWindowDuration // ignore: cast_nullable_to_non_nullable
              as int,
      fastingWindowStart: null == fastingWindowStart
          ? _value.fastingWindowStart
          : fastingWindowStart // ignore: cast_nullable_to_non_nullable
              as int,
      eatingWindowDuration: null == eatingWindowDuration
          ? _value.eatingWindowDuration
          : eatingWindowDuration // ignore: cast_nullable_to_non_nullable
              as int,
      fastingHours: null == fastingHours
          ? _value.fastingHours
          : fastingHours // ignore: cast_nullable_to_non_nullable
              as List<FastingHour>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FastingCopyWith<$Res> implements $FastingCopyWith<$Res> {
  factory _$$_FastingCopyWith(
          _$_Fasting value, $Res Function(_$_Fasting) then) =
      __$$_FastingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      int fastingWindowDuration,
      int fastingWindowStart,
      int eatingWindowDuration,
      List<FastingHour> fastingHours});
}

/// @nodoc
class __$$_FastingCopyWithImpl<$Res>
    extends _$FastingCopyWithImpl<$Res, _$_Fasting>
    implements _$$_FastingCopyWith<$Res> {
  __$$_FastingCopyWithImpl(_$_Fasting _value, $Res Function(_$_Fasting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? fastingWindowDuration = null,
    Object? fastingWindowStart = null,
    Object? eatingWindowDuration = null,
    Object? fastingHours = null,
  }) {
    return _then(_$_Fasting(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      fastingWindowDuration: null == fastingWindowDuration
          ? _value.fastingWindowDuration
          : fastingWindowDuration // ignore: cast_nullable_to_non_nullable
              as int,
      fastingWindowStart: null == fastingWindowStart
          ? _value.fastingWindowStart
          : fastingWindowStart // ignore: cast_nullable_to_non_nullable
              as int,
      eatingWindowDuration: null == eatingWindowDuration
          ? _value.eatingWindowDuration
          : eatingWindowDuration // ignore: cast_nullable_to_non_nullable
              as int,
      fastingHours: null == fastingHours
          ? _value._fastingHours
          : fastingHours // ignore: cast_nullable_to_non_nullable
              as List<FastingHour>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fasting implements _Fasting {
  const _$_Fasting(
      {required this.title,
      required this.description,
      required this.fastingWindowDuration,
      required this.fastingWindowStart,
      required this.eatingWindowDuration,
      required final List<FastingHour> fastingHours})
      : _fastingHours = fastingHours;

  factory _$_Fasting.fromJson(Map<String, dynamic> json) =>
      _$$_FastingFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final int fastingWindowDuration;
  @override
  final int fastingWindowStart;
  @override
  final int eatingWindowDuration;
  final List<FastingHour> _fastingHours;
  @override
  List<FastingHour> get fastingHours {
    if (_fastingHours is EqualUnmodifiableListView) return _fastingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fastingHours);
  }

  @override
  String toString() {
    return 'Fasting(title: $title, description: $description, fastingWindowDuration: $fastingWindowDuration, fastingWindowStart: $fastingWindowStart, eatingWindowDuration: $eatingWindowDuration, fastingHours: $fastingHours)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Fasting &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.fastingWindowDuration, fastingWindowDuration) ||
                other.fastingWindowDuration == fastingWindowDuration) &&
            (identical(other.fastingWindowStart, fastingWindowStart) ||
                other.fastingWindowStart == fastingWindowStart) &&
            (identical(other.eatingWindowDuration, eatingWindowDuration) ||
                other.eatingWindowDuration == eatingWindowDuration) &&
            const DeepCollectionEquality()
                .equals(other._fastingHours, _fastingHours));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      description,
      fastingWindowDuration,
      fastingWindowStart,
      eatingWindowDuration,
      const DeepCollectionEquality().hash(_fastingHours));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FastingCopyWith<_$_Fasting> get copyWith =>
      __$$_FastingCopyWithImpl<_$_Fasting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FastingToJson(
      this,
    );
  }
}

abstract class _Fasting implements Fasting {
  const factory _Fasting(
      {required final String title,
      required final String description,
      required final int fastingWindowDuration,
      required final int fastingWindowStart,
      required final int eatingWindowDuration,
      required final List<FastingHour> fastingHours}) = _$_Fasting;

  factory _Fasting.fromJson(Map<String, dynamic> json) = _$_Fasting.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  int get fastingWindowDuration;
  @override
  int get fastingWindowStart;
  @override
  int get eatingWindowDuration;
  @override
  List<FastingHour> get fastingHours;
  @override
  @JsonKey(ignore: true)
  _$$_FastingCopyWith<_$_Fasting> get copyWith =>
      throw _privateConstructorUsedError;
}

FastingHour _$FastingHourFromJson(Map<String, dynamic> json) {
  return _FastingHour.fromJson(json);
}

/// @nodoc
mixin _$FastingHour {
  int get start => throw _privateConstructorUsedError;
  int get end => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get colorHex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FastingHourCopyWith<FastingHour> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingHourCopyWith<$Res> {
  factory $FastingHourCopyWith(
          FastingHour value, $Res Function(FastingHour) then) =
      _$FastingHourCopyWithImpl<$Res, FastingHour>;
  @useResult
  $Res call({int start, int end, String description, String colorHex});
}

/// @nodoc
class _$FastingHourCopyWithImpl<$Res, $Val extends FastingHour>
    implements $FastingHourCopyWith<$Res> {
  _$FastingHourCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? description = null,
    Object? colorHex = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FastingHourCopyWith<$Res>
    implements $FastingHourCopyWith<$Res> {
  factory _$$_FastingHourCopyWith(
          _$_FastingHour value, $Res Function(_$_FastingHour) then) =
      __$$_FastingHourCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int start, int end, String description, String colorHex});
}

/// @nodoc
class __$$_FastingHourCopyWithImpl<$Res>
    extends _$FastingHourCopyWithImpl<$Res, _$_FastingHour>
    implements _$$_FastingHourCopyWith<$Res> {
  __$$_FastingHourCopyWithImpl(
      _$_FastingHour _value, $Res Function(_$_FastingHour) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? description = null,
    Object? colorHex = null,
  }) {
    return _then(_$_FastingHour(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FastingHour implements _FastingHour {
  const _$_FastingHour(
      {required this.start,
      required this.end,
      required this.description,
      required this.colorHex});

  factory _$_FastingHour.fromJson(Map<String, dynamic> json) =>
      _$$_FastingHourFromJson(json);

  @override
  final int start;
  @override
  final int end;
  @override
  final String description;
  @override
  final String colorHex;

  @override
  String toString() {
    return 'FastingHour(start: $start, end: $end, description: $description, colorHex: $colorHex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FastingHour &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, start, end, description, colorHex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FastingHourCopyWith<_$_FastingHour> get copyWith =>
      __$$_FastingHourCopyWithImpl<_$_FastingHour>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FastingHourToJson(
      this,
    );
  }
}

abstract class _FastingHour implements FastingHour {
  const factory _FastingHour(
      {required final int start,
      required final int end,
      required final String description,
      required final String colorHex}) = _$_FastingHour;

  factory _FastingHour.fromJson(Map<String, dynamic> json) =
      _$_FastingHour.fromJson;

  @override
  int get start;
  @override
  int get end;
  @override
  String get description;
  @override
  String get colorHex;
  @override
  @JsonKey(ignore: true)
  _$$_FastingHourCopyWith<_$_FastingHour> get copyWith =>
      throw _privateConstructorUsedError;
}

FastingTimer _$FastingTimerFromJson(Map<String, dynamic> json) {
  return _FastingTimer.fromJson(json);
}

/// @nodoc
mixin _$FastingTimer {
  int get hours => throw _privateConstructorUsedError;
  int get minutes => throw _privateConstructorUsedError;
  int get seconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FastingTimerCopyWith<FastingTimer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingTimerCopyWith<$Res> {
  factory $FastingTimerCopyWith(
          FastingTimer value, $Res Function(FastingTimer) then) =
      _$FastingTimerCopyWithImpl<$Res, FastingTimer>;
  @useResult
  $Res call({int hours, int minutes, int seconds});
}

/// @nodoc
class _$FastingTimerCopyWithImpl<$Res, $Val extends FastingTimer>
    implements $FastingTimerCopyWith<$Res> {
  _$FastingTimerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(_value.copyWith(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FastingTimerCopyWith<$Res>
    implements $FastingTimerCopyWith<$Res> {
  factory _$$_FastingTimerCopyWith(
          _$_FastingTimer value, $Res Function(_$_FastingTimer) then) =
      __$$_FastingTimerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hours, int minutes, int seconds});
}

/// @nodoc
class __$$_FastingTimerCopyWithImpl<$Res>
    extends _$FastingTimerCopyWithImpl<$Res, _$_FastingTimer>
    implements _$$_FastingTimerCopyWith<$Res> {
  __$$_FastingTimerCopyWithImpl(
      _$_FastingTimer _value, $Res Function(_$_FastingTimer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(_$_FastingTimer(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FastingTimer extends _FastingTimer {
  const _$_FastingTimer(
      {required this.hours, required this.minutes, required this.seconds})
      : super._();

  factory _$_FastingTimer.fromJson(Map<String, dynamic> json) =>
      _$$_FastingTimerFromJson(json);

  @override
  final int hours;
  @override
  final int minutes;
  @override
  final int seconds;

  @override
  String toString() {
    return 'FastingTimer(hours: $hours, minutes: $minutes, seconds: $seconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FastingTimer &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hours, minutes, seconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FastingTimerCopyWith<_$_FastingTimer> get copyWith =>
      __$$_FastingTimerCopyWithImpl<_$_FastingTimer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FastingTimerToJson(
      this,
    );
  }
}

abstract class _FastingTimer extends FastingTimer {
  const factory _FastingTimer(
      {required final int hours,
      required final int minutes,
      required final int seconds}) = _$_FastingTimer;
  const _FastingTimer._() : super._();

  factory _FastingTimer.fromJson(Map<String, dynamic> json) =
      _$_FastingTimer.fromJson;

  @override
  int get hours;
  @override
  int get minutes;
  @override
  int get seconds;
  @override
  @JsonKey(ignore: true)
  _$$_FastingTimerCopyWith<_$_FastingTimer> get copyWith =>
      throw _privateConstructorUsedError;
}
