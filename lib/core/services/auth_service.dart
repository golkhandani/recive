import 'dart:async';
import 'dart:io';
import 'package:art_for_all/core/ioc/i_secure_storage.dart';
import 'package:art_for_all/core/ioc/i_shared_storage.dart';
import 'package:art_for_all/core/ioc/locator.dart';
import 'package:art_for_all/core/models/user_abstract_model.dart';
import 'package:art_for_all/core/services/navigation_service.dart';
import 'package:art_for_all/core/services/notification_banner_service.dart';
import 'package:art_for_all/environment.dart';
import 'package:art_for_all/modules/auth_screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as p;

typedef UserSession = ({User user, Session session});

abstract class IUserService {
  bool get isLoggedIn => false;
  Future<UserSession> loginWithEmail({
    required String email,
    required String password,
  });

  Future<User> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<UserAbstractModel?> getCurrentUser();

  Future<void> restoreSession();

  Future<void> setupRefreshTokenTimer();

  Future<void> logout();

  Future<void> delete();

  Future<String> uploadAvatar(String path);

  Future<UserAbstractModel?> updateUser({String? imageUrl, String? name});
}

class SupabaseUserService implements IUserService {
  final SupabaseClient _supabase;
  final ISecureStorage secureStorage;
  final ISharedStorage sharedStorage;
  SupabaseUserService({
    required SupabaseClient supabase,
    required this.secureStorage,
    required this.sharedStorage,
  }) : _supabase = supabase {
    _supabase.auth.onAuthStateChange.listen((event) async {
      switch (event.event) {
        case AuthChangeEvent.signedOut:
          _timer?.cancel();
          _timer = null;
          break;
        default:
          if (event.session != null) {
            await setupRefreshTokenTimer();
          }
      }
    });
  }

  @override
  bool get isLoggedIn => _supabase.auth.currentSession != null;

  @override
  Future<UserSession> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      final User? user = res.user;

      if (user == null || session == null) {
        throw Exception('Invalid login');
      }
      return (user: user, session: session);
    } on AuthException catch (e, s) {
      Logger.warn("loginWithEmail known error", e, s);
      rethrow;
    } on Exception catch (e, s) {
      Logger.error("loginWithEmail known error", e, s);
      rethrow;
    }
  }

  @override
  Future<User> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null,
        data: {
          "imageUrl": null,
          "name": null,
        },
      );

      final User? user = res.user;

      if (user == null) {
        throw Exception('Invalid login');
      }

      return user;
    } on AuthException catch (e, s) {
      Logger.warn("signUpWithEmail known error", e, s);
      rethrow;
    } on Exception catch (e, s) {
      Logger.error("signUpWithEmail error", e, s);
      rethrow;
    }
  }

  Future<String?> _getAvatarUrl(String? path) async {
    if (path == null) {
      return null;
    }
    final imageUrl = await _supabase.storage
        .from('avatars')
        .createSignedUrl(path.replaceFirstMapped('avatars/', (s) => ""), 360000);

    return imageUrl;
  }

  @override
  Future<UserAbstractModel?> getCurrentUser() async {
    final User? user = _supabase.auth.currentUser;
    if (user == null) {
      return null;
    }
    final data = user.userMetadata;
    final imageUrl = await _getAvatarUrl(data?["imageUrl"]);

    final userData = UserAbstractModel(
      id: user.id,
      email: user.email ?? "",
      name: data?["name"] ?? "",
      lastLocation: "",
      imageUrl: imageUrl ?? "",
      tags: [],
    );
    return userData;
  }

  @override
  Future<void> restoreSession() async {
    final sharedStorage = locator.get<ISharedStorage>();
    bool exist = await sharedStorage.containsKey(key: Environment.supabaseKey);
    if (!exist) {
      return;
    }

    String? jsonStr = await sharedStorage.read(key: Environment.persistSessionKey);
    if (jsonStr == null) {
      return;
    }

    final supabaseClient = locator.get<SupabaseClient>();
    final response = await supabaseClient.auth.recoverSession(jsonStr);
    if (response.session != null) {
      await sharedStorage.delete(key: Environment.persistSessionKey);
      return;
    }

    sharedStorage.write(
      key: Environment.persistSessionKey,
      value: response.session?.toJson().toString() ?? '{}',
    );
    final message = 'Welcome ${response.user!.email}';
    locator.get<NotificationBannerService>().showErrorBanner(message);
  }

  Timer? _timer;
  @override
  Future<void> setupRefreshTokenTimer() async {
    _timer ??= Timer.periodic(const Duration(seconds: 1800), (_) async {
      try {
        Logger.info("setupRefreshTokenTimer done");
        await restoreSession();
      } catch (e, s) {
        Logger.error("setupRefreshTokenTimer error", e, s);
        await logout();
      }
    });
  }

  @override
  Future<void> logout() async {
    final sharedStorage = locator.get<ISharedStorage>();
    final supabase = locator.get<SupabaseClient>();
    await sharedStorage.clear();
    await supabase.auth.signOut();
    Logger.info("logout done");
    Router.neglect(rootNavigatorKey.currentContext!, () {
      rootNavigatorKey.currentContext!.goNamed(LoginScreen.name);
    });
  }

  @override
  Future<void> delete() async {
    final sharedStorage = locator.get<ISharedStorage>();
    final supabase = locator.get<SupabaseClient>();
    await sharedStorage.clear();
    await supabase.auth.signOut();

    // TODO: call edge function to delete account
    Logger.info("delete done");
    Router.neglect(rootNavigatorKey.currentContext!, () {
      rootNavigatorKey.currentContext!.goNamed(LoginScreen.name);
    });
  }

  @override
  Future<UserAbstractModel?> updateUser({String? imageUrl, String? name}) async {
    final data = _supabase.auth.currentUser?.userMetadata;
    await _supabase.auth.updateUser(UserAttributes(data: {
      "imageUrl": imageUrl ?? data?["imageUrl"],
      "name": name ?? data?["name"],
    }));
    final userData = await getCurrentUser();
    return userData;
  }

  @override
  Future<String> uploadAvatar(String path) async {
    final id = _supabase.auth.currentUser?.id;
    if (id == null) {
      await logout();
      return "";
    }
    final avatarFile = File(path);

    final String fullPath = await _supabase.storage.from('avatars').upload(
          'public/$id${p.extension(path)}',
          avatarFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
    await updateUser(imageUrl: fullPath);
    final imageUrl = await _getAvatarUrl(fullPath);
    if (imageUrl == null) {
      throw Exception('Something went wrong!');
    }
    return imageUrl;
  }
}
