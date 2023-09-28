import 'package:flutter_map/flutter_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/shared/constants/key_constants.dart';
import 'package:recive/shared/utils/maybe_emit_cubit.dart';

part 'map_control_cubit.freezed.dart';
part 'map_control_cubit.g.dart';

@freezed
class MapControlState with _$MapControlState {
  static const double defaultZoom = 15;
  const factory MapControlState({
    required LatLng userLocation,
    required bool showRefresh,
    required LatLng center,
    required double zoom,
    required bool mapInitialized,
    required int interations,
  }) = _MapControlState;

  factory MapControlState.initialize() => const MapControlState(
      userLocation: DefaultConstant.defaultPosition,
      showRefresh: false,
      center: DefaultConstant.defaultPosition,
      zoom: defaultZoom,
      mapInitialized: false,
      interations: InteractiveFlag.all & ~InteractiveFlag.rotate);

  factory MapControlState.fromJson(Map<String, Object?> json) =>
      _$MapControlStateFromJson(json);
}

class MapControlCubit extends MaybeEmitHydratedCubit<MapControlState> {
  MapControlCubit() : super(MapControlState.initialize());

  updateState(MapControlState updatedState) {
    maybeEmit(updatedState);
  }

  @override
  MapControlState? fromJson(Map<String, dynamic> json) {
    return MapControlState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(MapControlState state) {
    return state.toJson();
  }
}
