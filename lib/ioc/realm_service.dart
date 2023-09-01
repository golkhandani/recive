import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:realm/realm.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/profile_page/models/user_custom_data.dart';
import 'package:recive/router/navigation_service.dart';

class RealmApplicationService {
  static const isLoggedInKey = 'isLoggedInKey';
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';

  final App app;
  final FlutterSecureStorage storage;
  final NavigationService navigationService;
  Timer? _timer;
  User? get currentUser => app.currentUser;

  RealmApplicationService({
    required this.app,
    required this.storage,
    required this.navigationService,
  });

  Future<void> initRefreshHandler() async {
    await updateToken();
    print("Timer.periodic => ${_timer == null}");
    _timer ??= Timer.periodic(Duration(minutes: 15), (_) async {
      try {
        print("Timer.periodic => update user data");
        await checkLogin();
      } catch (e) {
        cancelRefreshHandler();
        await deleteTokens();
        await logout();
        await navigationService.logoutTo(LoginScreen.name);
      }
    });
  }

  void cancelRefreshHandler() {
    _timer?.cancel();
  }

  Future<void> updateToken() async {
    try {
      await app.currentUser?.refreshCustomData();
      await storage.write(
          key: refreshTokenKey, value: app.currentUser?.refreshToken);
      await storage.write(
        key: accessTokenKey,
        value: app.currentUser?.accessToken,
      );
      await storage.write(key: isLoggedInKey, value: true.toString());
    } catch (e) {
      await navigationService.logoutTo(LoginScreen.name);
    }
  }

  Future<void> logout() async {
    try {
      await app.currentUser?.logOut();
    } finally {
      await deleteTokens();
    }
  }

  Future<void> deleteTokens() async {
    await updateToken();
    await storage.delete(key: refreshTokenKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: isLoggedInKey);
    cancelRefreshHandler();
  }

  Future<void> delete() async {
    try {
      if (app.currentUser != null) {
        await app.deleteUser(app.currentUser!);
      }
      await logout();
    } finally {
      await deleteTokens();
    }
  }

  Future<void> loginWithGoogleId(
    String id, {
    UserCustomData? data,
  }) async {
    // 337988051792-khuhmiv6pjgv50dd2ap94puaj2fp7lls.apps.googleusercontent.com
    // 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
    /**
     * {"web":{"client_id":"337988051792-khuhmiv6pjgv50dd2ap94puaj2fp7lls.apps.googleusercontent.com","project_id":"recive-mzg","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"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"}}
     */
    await login(Credentials.googleIdToken(id));
    final userData = data?.copyWith(userId: currentUser?.id);
    if (userData != null) {
      await currentUser?.functions.call(
        "writeCustomUserData",
        [userData.toJson()],
      );
    }
    await currentUser?.refreshCustomData();

    return;
  }

  Future<void> login(Credentials c) async {
    try {
      final user = await app.logIn(c);
      await updateToken();
      print(user.deviceId);
    } catch (e) {
      print(e);
      await deleteTokens();
    }
  }

  Future<bool> checkLogin() async {
    await updateToken();
    try {
      final refreshToken = await storage.read(key: refreshTokenKey);
      final accessToken = await storage.read(key: accessTokenKey);
      final isLoggedIn = await storage.read(key: isLoggedInKey);

      print("${refreshToken} ${accessToken} ${isLoggedIn}");
      app.reconnect();

      if (app.currentUser?.state == null ||
          refreshToken == null ||
          accessToken == null ||
          isLoggedIn == null ||
          isLoggedIn == 'false') {
        await deleteTokens();
        await initRefreshHandler();
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      await deleteTokens();
      return false;
    }
    // return true;
  }
}
