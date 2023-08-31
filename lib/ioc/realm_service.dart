import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:realm/realm.dart';
import 'package:recive/features/login_page/cubits/login_cubit.dart';
import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/router/navigation_service.dart';

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
  // final appConfig = AppConfiguration(
  //   'suggesteventpath-mgnsw',
  //   baseUrl: Uri.parse('https://us-east-1.aws.realm.mongodb.com'),
  //   httpClient: HttpClient(),
  //   maxConnectionTimeout: const Duration(seconds: 120),
  //   defaultRequestTimeout: const Duration(seconds: 120),
  //   localAppVersion: '2.0',
  // );
  // late final app = App(appConfig);
  final FlutterSecureStorage storage;
  final NavigationService navigationService;
  Timer? _timer;
  dynamic? get currentUser => null;

  RealmApplicationService({
    required this.storage,
    required this.navigationService,
  });

  Future<void> initRefreshHandler() async {
    // await updateToken();
    // print("Timer.periodic => ${_timer == null}");
    // _timer ??= Timer.periodic(Duration(minutes: 15), (_) async {
    //   try {
    //     print("Timer.periodic => update user data");
    //     await app.currentUser?.refreshCustomData();
    //     await updateToken();
    //   } catch (e) {
    //     cancelRefreshHandler();
    //     await deleteTokens();
    //     await logout();
    //     await navigationService.logoutTo(LoginScreen.name);
    //   }
    // });
  }

  void cancelRefreshHandler() {
    _timer?.cancel();
  }

  Future<void> updateToken() async {
    // await storage.write(
    //     key: refreshTokenKey, value: app.currentUser?.refreshToken);
    // await storage.write(
    //   key: accessTokenKey,
    //   value: app.currentUser?.accessToken,
    // );
    // await storage.write(key: isLoggedInKey, value: true.toString());
  }

  Future<void> logout() async {
    // try {
    //   await app.currentUser?.logOut();
    // } finally {
    //   await deleteTokens();
    // }
  }

  Future<void> deleteTokens() async {
    // await updateToken();
    // await storage.delete(key: refreshTokenKey);
    // await storage.delete(key: accessTokenKey);
    // await storage.delete(key: isLoggedInKey);
    // cancelRefreshHandler();
  }

  Future<void> delete() async {
    // try {
    //   if (app.currentUser != null) {
    //     await app.deleteUser(app.currentUser!);
    //   }
    //   await logout();
    // } finally {
    //   await deleteTokens();
    // }
  }

  Future<void> login(dynamic c) async {
    // try {
    //   final user = await app.logIn(c);
    //   await updateToken();
    //   print(user.deviceId);
    // } catch (e) {
    //   await deleteTokens();
    // }
  }

  Future<bool> checkLogin() async {
    // try {
    //   final refreshToken = await storage.read(key: refreshTokenKey);
    //   final accessToken = await storage.read(key: accessTokenKey);
    //   final isLoggedIn = await storage.read(key: isLoggedInKey);

    //   print("${refreshToken} ${accessToken} ${isLoggedIn}");
    //   app.reconnect();

    //   if (app.currentUser?.state == null ||
    //       refreshToken == null ||
    //       accessToken == null ||
    //       isLoggedIn == null ||
    //       isLoggedIn == 'false') {
    //     await initRefreshHandler();
    //     return false;
    //   } else {
    //     return true;
    //   }
    // } catch (e) {
    //   await deleteTokens();
    //   return false;
    // }
    return true;
  }
}
