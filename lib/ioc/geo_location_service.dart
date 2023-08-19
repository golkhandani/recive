import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:location/location.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';

@immutable
class UserLocation {
  const UserLocation({
    this.timestamp,
    this.fetched = false,
    this.position,
  });

  final bool fetched;
  final LocationData? position;
  final DateTime? timestamp;
}

extension PositionToLocationData on Position {
  LocationData get toLocationData => LocationData.fromMap(toJson());
  bool compareTo(Position? otherPosition) {
    if (longitude == otherPosition?.longitude &&
        latitude == otherPosition?.latitude &&
        timestamp == otherPosition?.timestamp &&
        accuracy == otherPosition?.accuracy &&
        altitude == otherPosition?.altitude &&
        heading == otherPosition?.heading &&
        speed == otherPosition?.speed &&
        speedAccuracy == otherPosition?.speedAccuracy &&
        floor == otherPosition?.floor &&
        isMocked == otherPosition?.isMocked) {
      return true;
    }
    return false;
  }
}

extension UserLocationToLatLon on UserLocation {
  LatLng? get latLng =>
      position?.latitude != null && position?.longitude != null
          ? LatLng(
              position!.latitude!,
              position!.longitude!,
            )
          : null;
}

class LocationService {
  LocationService._();

  /// the one and only instance of this singleton
  static final instance = LocationService._();

  final Location location = Location();
  bool? _serviceEnabled;
  Future<void> _checkService() async {
    final serviceEnabledResult = await location.serviceEnabled();
    _serviceEnabled = serviceEnabledResult;
  }

  Future<void> requestService({
    required VoidCallback onGrantedPermission,
  }) async {
    await _checkService();
    if (_serviceEnabled == true) {
      final data = await location.getLocation();
      if (lastUserLocation?.position != data) {
        lastUserLocation = UserLocation(
          fetched: true,
          position: data,
          timestamp: DateTime.now(),
        );
      }
      onGrantedPermission();
    }
    if (_serviceEnabled ?? false) {
      if (_serviceEnabled == true) {}

      return;
    }

    final serviceRequestedResult = await location.requestService();
    _serviceEnabled = serviceRequestedResult;
    onGrantedPermission();
  }

  UserLocation? lastUserLocation;
}

final locationService = LocationService.instance;

/// Tracks the state of user's geographic location using [geolocator](ref link).
/// [ref link](https://pub.dev/packages/geolocator)
UserLocation useUserLocation({
  LocationSettings? locationSettings,
}) {
  locationService.requestService(onGrantedPermission: () => {});

  final state = useRef(
    locationService.lastUserLocation ?? const UserLocation(),
  );
  final positionChanged = useStream(useMemoized(() {
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }));

  final locationData = positionChanged.data?.toLocationData;
  final isUpdated =
      (locationData?.time ?? 0) > (state.value.position?.time ?? 0);

  if ((positionChanged.hasData && isUpdated) || !state.value.fetched) {
    state.value = UserLocation(
      fetched: positionChanged.hasData,
      position: locationData,
      timestamp: DateTime.now(),
    );
  }

  if (state.value.position != null) {
    locationService.lastUserLocation = state.value;
  }
  return state.value;
}
