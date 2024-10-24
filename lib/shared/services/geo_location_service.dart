import 'package:flutter/foundation.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:recive/shared/ioc/locator.dart';

@immutable
class UserLocation {
  const UserLocation({
    this.timestamp,
    this.fetched = false,
    this.position,
  });

  final bool fetched;
  final Position? position;
  final DateTime? timestamp;
}

extension PositionToLocationData on Position {
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
  LatLng? get latLng => position?.latitude != null && position?.longitude != null
      ? LatLng(
          position!.latitude,
          position!.longitude,
        )
      : null;
}

extension PositionToLatLon on Position? {
  LatLng? get latLng => this?.latitude != null && this?.longitude != null
      ? LatLng(
          this!.latitude,
          this!.longitude,
        )
      : null;
}

class LocationService {
  LocationService._();

  /// the one and only instance of this singleton
  static final instance = LocationService._();

  final geolocator = GeolocatorPlatform.instance;
  late bool serviceEnabled;
  late LocationPermission _permission;
  UserLocation? lastUserLocation;

  void openSetting() {
    Geolocator.openLocationSettings();
  }

  Future<LocationPermission> getPermissionSetting() async {
    _permission = await Geolocator.requestPermission();
    return _permission;
  }

  Future<void> requestService({
    required Function(LocationPermission) onDone,
  }) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    _permission = await Geolocator.requestPermission();

    if (!serviceEnabled && _permission == LocationPermission.deniedForever) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      locator.logger.d("__| LocationService 2 $serviceEnabled");
      return onDone(_permission);
      // return Future.error('Location services are disabled.');
    }
    locator.logger.d("__| LocationService 1 $serviceEnabled");

    _permission = await Geolocator.checkPermission();
    if (serviceEnabled) {
      return onDone(_permission);
    }
    locator.logger.d("__| LocationService 3 $serviceEnabled");
    if (_permission == LocationPermission.denied) {
      locator.logger.d("__| LocationService 4 $serviceEnabled");
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        locator.logger.d("__| LocationService 5 $serviceEnabled");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return onDone(_permission);
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      locator.logger.d("__| LocationService 7 $serviceEnabled");
      // Permissions are denied forever, handle appropriately.
      return onDone(_permission);
    }

    final position = await Geolocator.getCurrentPosition();
    lastUserLocation = UserLocation(
      fetched: true,
      position: position,
      timestamp: position.timestamp,
    );
    return onDone(_permission);
  }

  updateUastUserLocation(Position? position) {
    lastUserLocation = UserLocation(
      fetched: true,
      position: position,
      timestamp: position?.timestamp,
    );
  }

  DateTime? get getLastTimestamp => lastUserLocation?.timestamp;
}

final locationService = LocationService.instance;

extension LocationPermissionHelper on LocationPermission {
  bool get isPermitted => this == LocationPermission.always || this == LocationPermission.whileInUse;
}

Position? useLocationData({
  required String debugLabel,
}) {
  locator.logger.d("$debugLabel - useLocationData");

  final locationData = useState<Position?>(locationService.lastUserLocation?.position);

  useEffect(() {
    const locationOptions = LocationSettings(
      distanceFilter: 10,
    );

    final locationStream =
        locationService.geolocator.getPositionStream(locationSettings: locationOptions).listen((position) {
      final exp = position.timestamp.add(const Duration(seconds: 120));
      if ((position.timestamp.isAfter(exp)) || locationData.value == null) {
        locationData.value = position;
        locationService.updateUastUserLocation(position);
      }
    });

    return () {
      locationStream.cancel();
    };
  }, []);

  return locationData.value;
}

/// Tracks the state of user's geographic location using [geolocator](ref link).
/// [ref link](https://pub.dev/packages/geolocator)
UserLocation useUserLocation({
  required String debugLabel,
  LocationSettings? locationSettings,
}) {
  locator.logger.d("_________________| useUserLocation");

  locationService.requestService(onDone: (permission) => {});

  final mount = useIsMounted();
  final state = useRef(
    locationService.lastUserLocation ?? const UserLocation(),
  );

  final isUpdated =
      (locationService.lastUserLocation?.timestamp?.difference(DateTime.now()).inSeconds ?? double.infinity).abs() > 20;

  if (!isUpdated && !mount()) {
    return state.value;
  }

  final settings = locationSettings ??
      const LocationSettings(
        timeLimit: Duration(seconds: 120),
      );

  final positionChanged = useStream(useMemoized(() {
    locator.logger.d("_________________| useMemoized useUserLocation");

    return Geolocator.getPositionStream(locationSettings: settings);
  }));

  final locationData = positionChanged.data;

  if ((positionChanged.hasData && isUpdated) || !state.value.fetched) {
    state.value = UserLocation(
      fetched: locationData?.latitude != null && locationData?.longitude != null && positionChanged.hasData,
      position: locationData,
      timestamp: locationData?.timestamp,
    );
  }

  if (state.value.position != null) {
    locationService.updateUastUserLocation(state.value.position);
  }

  locator.logger.d("1 $debugLabel $debugLabel ${DateTime.now()}");
  locator.logger.d("2 locationData ${locationData?.timestamp}");
  locator.logger.d("3 locationData ${locationService.getLastTimestamp}");

  return state.value;
}
