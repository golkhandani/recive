import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

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
  LatLng? get latLng =>
      position?.latitude != null && position?.longitude != null
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
  late LocationPermission permission;
  UserLocation? lastUserLocation;

  Future<void> requestService({
    required VoidCallback onGrantedPermission,
  }) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      return;
    }
    debugPrint("__| LocationService 1 $serviceEnabled");
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      debugPrint("__| LocationService 2 $serviceEnabled");
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    debugPrint("__| LocationService 3 $serviceEnabled");
    if (permission == LocationPermission.denied) {
      debugPrint("__| LocationService 4 $serviceEnabled");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("__| LocationService 5 $serviceEnabled");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("__| LocationService 7 $serviceEnabled");
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();
    lastUserLocation = UserLocation(
      fetched: true,
      position: position,
      timestamp: position.timestamp,
    );
    return onGrantedPermission();
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

Position? useLocationData({
  required String debugLabel,
}) {
  if (kDebugMode) {
    print("_________________| $debugLabel - useLocationData");
  }

  final locationData =
      useState<Position?>(locationService.lastUserLocation?.position);

  useEffect(() {
    const locationOptions = LocationSettings(
      distanceFilter: 10,
    );

    final locationStream = locationService.geolocator
        .getPositionStream(locationSettings: locationOptions)
        .listen((position) {
      final exp = position.timestamp?.add(const Duration(seconds: 120));
      if ((position.timestamp != null && position.timestamp!.isAfter(exp!)) ||
          locationData.value == null) {
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
  if (kDebugMode) {
    print("_________________| useUserLocation");
  }

  locationService.requestService(onGrantedPermission: () => {});

  final mount = useIsMounted();
  final state = useRef(
    locationService.lastUserLocation ?? const UserLocation(),
  );

  final isUpdated = (locationService.lastUserLocation?.timestamp
                  ?.difference(DateTime.now())
                  .inSeconds ??
              double.infinity)
          .abs() >
      20;

  if (!isUpdated && !mount()) {
    return state.value;
  }

  final settings = locationSettings ??
      const LocationSettings(
        timeLimit: Duration(seconds: 120),
      );

  final positionChanged = useStream(useMemoized(() {
    if (kDebugMode) {
      print("_________________| useMemoized useUserLocation");
    }
    return Geolocator.getPositionStream(locationSettings: settings);
  }));

  final locationData = positionChanged.data;

  if ((positionChanged.hasData && isUpdated) || !state.value.fetched) {
    state.value = UserLocation(
      fetched: locationData?.latitude != null &&
          locationData?.longitude != null &&
          positionChanged.hasData,
      position: locationData,
      timestamp: locationData?.timestamp,
    );
  }

  if (state.value.position != null) {
    locationService.updateUastUserLocation(state.value.position);
  }
  if (kDebugMode) {
    print("1 $debugLabel $debugLabel ${DateTime.now()}");
    print("1 locationData ${locationData?.timestamp}");
    print("2 locationData ${locationService.getLastTimestamp}");
  }

  return state.value;
}
