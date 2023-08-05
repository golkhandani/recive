import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// add this property to the state class
/// @Default(null) DateTime? $cachedAt,
/// and
/// factory HydratedState.fromJson(Map<String, dynamic> json) =>_$HydratedStateFromJson(json);
abstract class HydratedState {
  static const Duration defaultValidDuration = Duration(seconds: 30);
  final DateTime? $cachedAt;

  const HydratedState({
    this.$cachedAt,
  });

  get copyWith;
  Map<String, dynamic> toJson();
  bool get isValidState => false;
}

extension HydratedStateHelper on HydratedState {
  HydratedState get $updated =>
      !$isValidCache ? copyWith($cachedAt: DateTime.now()) : this;
  bool get $isValidCache =>
      $cachedAt != null &&
      $cachedAt!
          .add(HydratedState.defaultValidDuration)
          .isAfter(DateTime.now());
}

extension HydratedBlocHelper on HydratedBloc {
  bool get _isCached =>
      HydratedBloc.storage.read(storageToken) != null &&
      (state is HydratedState) &&
      (state as HydratedState).$isValidCache;

  Future<void> $onInvalidCache(AsyncCallback? function) async {
    HydratedBloc.storage.read(storageToken);

    if (_isCached && (state as HydratedState).isValidState) {
      return;
    }
    await function?.call();
  }
}
