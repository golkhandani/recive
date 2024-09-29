import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceSharedStorage implements ISharedStorage {
  SharedPreferences? _preferences;
  DeviceSharedStorage._();
  // Initialize the SharedPreferences
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Factory constructor to allow async initialization
  static Future<DeviceSharedStorage> getInstance() async {
    var instance = DeviceSharedStorage._();
    await instance._init();
    return instance;
  }

  @override
  Future<bool> containsKey({required String key}) async {
    return _preferences?.containsKey(key) ?? false;
  }

  @override
  Future<void> delete({required String key}) async {
    await _preferences?.remove(key);
  }

  @override
  Future<void> clear() async {
    await _preferences?.clear();
  }

  @override
  Future<String?> read({required String key}) async {
    return _preferences?.getString(key);
  }

  @override
  Future<Map<String, String>> readAll() async {
    final Map<String, String> allPrefs = {};
    final keys = _preferences?.getKeys() ?? {};
    for (String key in keys) {
      final value = _preferences?.getString(key);
      if (value != null) {
        allPrefs[key] = value;
      }
    }
    return allPrefs;
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    if (value == null) {
      await _preferences?.remove(key);
    } else {
      await _preferences?.setString(key, value);
    }
  }
}
