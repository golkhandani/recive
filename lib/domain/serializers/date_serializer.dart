// ignore: depend_on_referenced_packages
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateSerializer implements PrimitiveSerializer<DateTime> {
  static final _format = DateFormat('yyyy-MM-dd');

  @override
  DateTime deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    assert(serialized is String,
        "DateSerializer expected 'String' but got ${serialized.runtimeType}");
    try {
      return _format.parse(serialized as String);
    } on Exception {
      if (kDebugMode) {
        print("ERROR: failed to parse data $serialized");
      }
    }

    return DateTime.now();
  }

  @override
  Object serialize(
    Serializers serializers,
    DateTime date, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      date.millisecondsSinceEpoch;

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => "Date";
}
