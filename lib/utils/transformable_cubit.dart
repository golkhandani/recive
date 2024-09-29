import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class TransformableCubit<T> extends Cubit<T> {
  TransformableCubit(super.initialState);

  Timer? _debounce;

  withDebounce(VoidCallback fn) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      fn();
    });
  }
}

abstract class HydratedTransformableCubit<T> extends HydratedCubit<T> {
  HydratedTransformableCubit(super.initialState);

  Timer? _debounce;

  withDebounce(VoidCallback fn) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      fn();
    });
  }
}
