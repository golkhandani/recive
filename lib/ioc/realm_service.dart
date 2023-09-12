import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:realm/realm.dart';

import 'package:recive/features/login_page/login_screen.dart';
import 'package:recive/features/profile_page/models/user_custom_data.dart';
import 'package:recive/ioc/locator.dart';
import 'package:recive/ioc/realm_gql_client.dart';
import 'package:recive/key_constants.dart';
import 'package:recive/router/navigation_service.dart';

class _Developer implements User {
  @override
  UserState get state => UserState.loggedIn;

  @override
  String get refreshToken => realmKey;

  @override
  String get accessToken => realmKey;

  @override
  ApiKeyClient get apiKeys => throw UnimplementedError();

  @override
  App get app => throw UnimplementedError();

  @override
  get customData => UserCustomData(
        userId: id,
        email: 'developer@dev.com',
        imageUrl: null,
        name: 'Developer',
      ).toJson();

  @override
  String? get deviceId => 'developer_device_id';
  @override
  String get id => 'developer_id';

  @override
  FunctionsClient get functions => throw UnimplementedError();

  @override
  List<UserIdentity> get identities => [];

  @override
  Future<User> linkCredentials(Credentials credentials) {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  get profile => throw UnimplementedError();

  @override
  AuthProviderType get provider => throw UnimplementedError();

  @override
  Future refreshCustomData() async {
    return customData;
  }
}

class RealmApplicationService {
  static const isLoggedInKey = 'isLoggedInKey';
  static const accessTokenKey = 'accessTokenKey';
  static const refreshTokenKey = 'refreshTokenKey';

  final App app;
  final FlutterSecureStorage storage;
  final NavigationService navigationService;
  Timer? _timer;
  User? _developer;
  bool get isDeveloper => currentUser is _Developer;
  User? get currentUser => _developer ?? app.currentUser;
  UserCustomData? get currentUserCustomData => currentUser?.customData != null
      ? UserCustomData.fromJson(
          currentUser?.customData,
        )
      : null;
  late final RealmGqlClient gql = locator.get<RealmGqlClient>();

  RealmApplicationService({
    required this.app,
    required this.storage,
    required this.navigationService,
  });

  Future<void> initRefreshHandler() async {
    await updateToken();
    locator.logger.d("________ | Timer.periodic: ${_timer == null}");
    _timer ??= Timer.periodic(const Duration(minutes: 15), (_) async {
      try {
        locator.logger.d("________ | Timer.periodic: update user data");
        await checkLogin();
      } catch (e) {
        locator.logger.e("________ | Timer.periodic: Error: ", error: e);
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
      await currentUser?.refreshCustomData();
      await storage.write(
          key: refreshTokenKey, value: currentUser?.refreshToken);
      await storage.write(
        key: accessTokenKey,
        value: currentUser?.accessToken,
      );
      await storage.write(key: isLoggedInKey, value: true.toString());
    } catch (e) {
      await navigationService.logoutTo(LoginScreen.name);
    }
  }

  Future<void> logout() async {
    try {
      _developer = null;
      await currentUser?.logOut();
      if (currentUser != null && !isDeveloper) {
        await app.removeUser(currentUser!);
      }
    } finally {
      await deleteTokens();
      gql.resetCache();
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
      if (currentUser != null && !isDeveloper) {
        await app.deleteUser(currentUser!);
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

  Future<void> loginWithApiKey() async {
    _developer = _Developer();
    await updateToken();
    gql.switchClient(isDeveloper: isDeveloper);
    return;
  }

  Future<void> login(Credentials c) async {
    try {
      final user = await app.logIn(c);
      await updateToken();
      gql.switchClient(isDeveloper: isDeveloper);
      locator.logger.d("________ | login: Success: ${user.id}");
    } catch (e) {
      locator.logger.e("________ | login: Error: ", error: e);
      await deleteTokens();
    }
  }

  Future<bool> checkLogin() async {
    try {
      await updateToken();
      app.reconnect();
      final refreshToken = await storage.read(key: refreshTokenKey);
      final accessToken = await storage.read(key: accessTokenKey);
      final isLoggedIn = await storage.read(key: isLoggedInKey);
      final isValid = currentUser?.state == null ||
          refreshToken == null ||
          accessToken == null ||
          isLoggedIn == null ||
          isLoggedIn == 'false';
      if (isValid) {
        await deleteTokens();
        await initRefreshHandler();
        return false;
      } else {
        return true;
      }
    } catch (e) {
      locator.logger.e("________ | checkLogin: Error: ", error: e);
      await deleteTokens();
      return false;
    }
  }

  ////
  Future<void> updateFavouriteEventIds(List<String> ids) async {
    final updatedCustomData = currentUserCustomData?.copyWith(
      bookmarkEvents: ids,
    );
    if (updatedCustomData != null) {
      await currentUser?.functions.call(
        "writeCustomUserData",
        [updatedCustomData.toJson()],
      );
    }

    return;
  }
}
