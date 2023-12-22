import 'package:dio/dio.dart';

import 'package:recive/modules/login_page/login_screen.dart';
import 'package:recive/shared/services/navigation_service.dart';
import 'package:recive/shared/services/realm_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.realmApplicationService,
    required this.navigationService,
    this.maxRetries = 3,
    this.isDeveloper = false,
  });

  /// The original dio
  final Dio dio;
  final RealmApplicationService realmApplicationService;
  final NavigationService navigationService;
  final bool isDeveloper;

  /// The number of retries in case of 401
  final int maxRetries;

  RequestOptions _seAuthHeaders(
    RequestOptions options, {
    required String token,
  }) {
    final accessToken = '${isDeveloper ? '' : 'Bearer '}$token';
    options.headers[!isDeveloper ? 'apiKey' : 'Authorization'] = null;
    options.headers[isDeveloper ? 'apiKey' : 'Authorization'] = accessToken;
    return options;
  }

  @override
  Future<void> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    final accessToken = realmApplicationService.currentUser?.accessToken;
    final refreshToken = realmApplicationService.currentUser?.refreshToken;
    if (accessToken == null && refreshToken == null) {
      return;
    } else if (accessToken != null) {
      final updatedOptions = _seAuthHeaders(options, token: accessToken);
      return handler.next(updatedOptions);
    } else {
      await realmApplicationService.logout();
      await navigationService.logoutTo(LoginScreen.name);
      return handler.reject(DioException(requestOptions: options));
    }
  }

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    final attempts = (err.requestOptions.headers['retry_attemts'] ?? 0) + 1;
    err.requestOptions.headers['retry_attemts'] = attempts;

    if (attempts > maxRetries) {
      return super.onError(err, handler);
    }

    final statusCode = err.response?.statusCode ?? 0;
    final isAuthError = statusCode == 401 || statusCode == 403;

    if (!isAuthError) {
      return super.onError(err, handler);
    }

    try {
      final options = err.requestOptions;
      await realmApplicationService.updateToken();
      final accessToken = realmApplicationService.currentUser?.accessToken;
      if (accessToken != null) {
        final updatedOptions = _seAuthHeaders(options, token: accessToken);
        final res = await dio.fetch(updatedOptions);
        return handler.resolve(res);
      } else {
        await realmApplicationService.logout();
        await navigationService.logoutTo(LoginScreen.name);
        return handler.reject(DioException(requestOptions: options));
      }
    } on DioException catch (e) {
      return handler.reject(e);
    } catch (e) {
      return handler.reject(DioException(requestOptions: err.requestOptions));
    }
  }
}
