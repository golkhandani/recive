import 'dart:async';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class ILocationService {
  Future<LocationPermission> getPermission();
  Future<bool> isServiceEnabled();
  Future<LatLng> getUserPosition();
  void addListener(LocationServiceListener fn);
  void removeListener(LocationServiceListener fn);
  LatLng get userLatLng;
}

typedef LocationServiceListener = void Function(LatLng latLng);

class LocalLocationService implements ILocationService {
  final GeolocatorPlatform _geolocator;
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  LocalLocationService({
    required GeolocatorPlatform geolocator,
    required this.secureStorage,
    required this.sharedStorage,
  }) : _geolocator = geolocator {
    _attachListeners();
  }

  void openSetting() {
    _geolocator.openLocationSettings();
  }

  LocationPermission? _permission;
  @override
  Future<LocationPermission> getPermission() async {
    if (_permission != null) {
      return _permission!;
    }
    _permission = await _geolocator.requestPermission();
    return _permission!;
  }

  bool? _isServiceEnabled;
  @override
  Future<bool> isServiceEnabled() async {
    if (_isServiceEnabled != null) {
      return _isServiceEnabled!;
    }
    _isServiceEnabled = await _geolocator.isLocationServiceEnabled();
    return _isServiceEnabled!;
  }

  @override
  Future<LatLng> getUserPosition() async {
    if (_isServiceEnabled == null) {
      await isServiceEnabled();
    }

    if (!_isServiceEnabled!) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    if (_permission == null) {
      await getPermission();
    }

    LocationPermission permission = _permission!;

    if (permission == LocationPermission.denied) {
      permission = await _geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await _geolocator.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }

  final Map<int, LocationServiceListener> listeners = {};

  @override
  void addListener(LocationServiceListener fn) {
    listeners.putIfAbsent(fn.hashCode, () => fn);
  }

  @override
  void removeListener(LocationServiceListener fn) {
    listeners.remove(fn.hashCode);
  }

  LatLng? _lastLatLng;

  @override
  LatLng get userLatLng => _lastLatLng ?? const LatLng(49.27, -123.069);

  void _attachListeners() {
    if (listeners.isEmpty) return;
    _geolocator.getPositionStream().listen((position) {
      final latLng = LatLng(position.latitude, position.longitude);
      if (_lastLatLng == latLng) return;
      final distance = _geolocator.distanceBetween(
        latLng.latitude,
        latLng.longitude,
        _lastLatLng?.latitude ?? 0.0,
        _lastLatLng?.longitude ?? 0.0,
      );
      if (distance < 1000) return;
      for (var listener in listeners.values) {
        listener(latLng);
      }
      _lastLatLng = latLng;
    });
  }
}
