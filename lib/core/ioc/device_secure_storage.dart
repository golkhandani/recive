import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceSecureStorage implements ISecureStorage {
  late final FlutterSecureStorage secureStorage;
  DeviceSecureStorage() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    secureStorage = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
    );
  }

  @override
  Future<bool> containsKey({
    required String key,
  }) {
    return secureStorage.containsKey(key: key);
  }

  @override
  Future<void> delete({
    required String key,
  }) {
    return secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() {
    return secureStorage.deleteAll();
  }

  @override
  Future<String?> read({
    required String key,
  }) {
    return secureStorage.read(key: key);
  }

  @override
  Future<Map<String, String>> readAll() {
    return secureStorage.readAll();
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
  }) {
    return secureStorage.write(key: key, value: value);
  }
}
