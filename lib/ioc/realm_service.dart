import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realm/realm.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: ['profile', 'email'],
    clientId:
        "337988051792-depkbem06p52nihpdd0jbea1bk4lqtpm.apps.googleusercontent.com"
    // AIzaSyBmaTbzEzC59qeAurCa4jq3Q67j7Q14Zv0
    );

class RealmApplicationService {
  static const isLoggedInKey = 'isLoggedInKey';
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';
  final appConfig = AppConfiguration(
    'suggesteventpath-mgnsw',
    defaultRequestTimeout: const Duration(seconds: 120),
    localAppVersion: '2.0',
  );
  late final app = App(appConfig);
  final FlutterSecureStorage storage;
  Timer? _timer;

  RealmApplicationService({
    required this.storage,
  });

  Future<void> initRefreshHandler() async {
    await updateToken();
    print("Timer.periodic => ${_timer == null}");
    _timer ??= Timer.periodic(Duration(minutes: 15), (_) async {
      print("Timer.periodic => update user data");
      await app.currentUser?.refreshCustomData();
      await updateToken();
    });
  }

  void cancelRefreshHandler() {
    _timer?.cancel();
  }

  Future<void> updateToken() async {
    await storage.write(
        key: refreshTokenKey, value: app.currentUser?.refreshToken);
    await storage.write(
      key: accessTokenKey,
      value: app.currentUser?.accessToken,
    );
    await storage.write(key: isLoggedInKey, value: true.toString());
  }

  Future<void> logout() async {
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: isLoggedInKey);
    await app.currentUser?.logOut();
    cancelRefreshHandler();
  }

  Future<void> login(Credentials c) async {
    final user = await app.logIn(c);
    await updateToken();
    print(user.deviceId);
  }

  Future<bool> checkLogin() async {
    final refreshToken = await storage.read(key: refreshTokenKey);
    final accessToken = await storage.read(key: accessTokenKey);
    final isLoggedIn = await storage.read(key: isLoggedInKey);

    print("${refreshToken} ${accessToken} ${isLoggedIn}");

    if (refreshToken == null ||
        accessToken == null ||
        isLoggedIn == null ||
        isLoggedIn == 'false') {
      await initRefreshHandler();
      return false;
    } else {
      return true;
    }
  }
}
