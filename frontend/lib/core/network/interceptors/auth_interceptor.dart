import 'package:dio/dio.dart';
import 'package:my_fm/common/bloc/auth/auth_cubit.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';
import 'package:my_fm/data/auth/storage/token_storage.dart';
import 'package:my_fm/domain/auth/repositories/auth_rep.dart';
import 'package:my_fm/service_locator.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;

  // Indicates if a refresh token request is currently running
  bool _isRefreshing = false;

  // Queue of pending requests waiting for a new access token
  final List<Function(String)> _queue = [];

  AuthInterceptor(this._dio);

  /// ---------------------------------------------------------------------------
  /// REQUEST INTERCEPTOR
  /// ---------------------------------------------------------------------------
  /// This method runs before every HTTP request.
  ///
  /// Responsibilities:
  /// - Attach the correct token to the Authorization header.
  /// - Use the refresh token when calling the refresh endpoint.
  /// - Use the access token for all other endpoints.
  /// ---------------------------------------------------------------------------
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await sl<TokenStorage>().getAccessToken();
    final refreshToken = await sl<TokenStorage>().getRefreshToken();

    // If the request is for refreshing the token,
    // use the refresh token in the Authorization header
    if (options.path.contains(ApiUrl.refreshToken)) {
      if (refreshToken != null) {
        options.headers['Authorization'] = 'Bearer $refreshToken';
      }
    }
    // Otherwise attach the access token
    else {
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    handler.next(options);
  }

  /// ---------------------------------------------------------------------------
  /// ERROR INTERCEPTOR
  /// ---------------------------------------------------------------------------
  /// This method runs when a request fails.
  ///
  /// Main goal:
  /// Handle expired access tokens by automatically refreshing them.
  ///
  /// Workflow:
  ///   1 Request fails with 401/403
  ///   2 Interceptor attempts to refresh the access token
  ///   3 If refresh succeeds:
  ///      - retry the original request
  ///      - process all queued requests
  ///   4 If refresh fails:
  ///      - clear stored tokens
  ///      - force user logout
  /// ---------------------------------------------------------------------------
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isAuthError =
        err.response?.statusCode == 401 || err.response?.statusCode == 403;
    final isRefreshCall = err.requestOptions.path.contains(ApiUrl.refreshToken);
    final isSignInCall = err.requestOptions.path.contains(ApiUrl.signIn);

    // If the error is not related to authentication
    // or if the refresh endpoint itself failed,
    // just forward the error.
    if (!isAuthError || isRefreshCall) {
      return handler.next(err);
    }

    /// -----------------------------------------------------------------------
    /// CASE 1: A refresh request is already running
    /// -----------------------------------------------------------------------
    /// Instead of triggering another refresh call,
    /// we queue the current request and wait for the new token.
    if (_isRefreshing) {
      _queue.add((token) async {
        // Update Authorization header with new token
        err.requestOptions.headers['Authorization'] = 'Bearer $token';

        // Retry the original request
        final response = await _dio.fetch(err.requestOptions);

        // Resolve the request with the new response
        handler.resolve(response);
      });

      return;
    }

    /// -----------------------------------------------------------------------
    /// CASE 2: No refresh in progress >> start refreshing token
    /// -----------------------------------------------------------------------
    _isRefreshing = true;

    try {
      final result = await sl<AuthRepository>().refreshToken();

      /// ---------------------------------------------------------------------
      /// REFRESH FAILED
      /// ---------------------------------------------------------------------
      /// This usually means:
      ///   - refresh token expired
      ///   - refresh token invalid
      ///
      /// In this case we:
      ///   - clear stored tokens
      ///   - force logout (if endpoint != signIn)
      if (result.isLeft()) {
        await sl<TokenStorage>().clearTokens();
        if (!isSignInCall) {
          sl<AuthCubit>().sessionExpired();
        }

        return handler.reject(err);
      }

      /// ---------------------------------------------------------------------
      /// REFRESH SUCCEEDED
      /// ---------------------------------------------------------------------
      /// - retrieve the new access token
      /// - retry all queued requests
      /// - retry the original failed request
      final newToken = await sl<TokenStorage>().getAccessToken();

      // Execute all queued requests
      for (final callback in _queue) {
        callback(newToken!);
      }
      _queue.clear();

      // Retry the original request with the new token
      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

      final response = await _dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } catch (_) {
      await sl<TokenStorage>().clearTokens();
      sl<AuthCubit>().sessionExpired();

      return handler.reject(err);
    } finally {
      // Reset refresh state
      _isRefreshing = false;
    }
  }
}
