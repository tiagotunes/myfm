import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_fm/core/configs/constants/api_url.dart';

class LoggerInterceptor extends Interceptor {
  /// Pretty print JSON
  String _prettyJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }

  /// Mask sensitive request data
  dynamic _sanitizeRequestBody(String path, dynamic body) {
    if (body == null) return body;

    final isSensitiveEndpoint =
        path.contains(ApiUrl.signIn) || path.contains(ApiUrl.signUp);

    if (!isSensitiveEndpoint) return body;

    if (body is Map<String, dynamic>) {
      final sanitized = Map<String, dynamic>.from(body);

      for (final key in sanitized.keys) {
        if (key.toLowerCase().contains('password') ||
            key.toLowerCase().contains('token') ||
            key.toLowerCase().contains('secret')) {
          sanitized[key] = '******';
        }
      }

      return sanitized;
    }

    return '******';
  }

  /// Mask tokens in responses
  dynamic _sanitizeResponseBody(dynamic body) {
    if (body is Map<String, dynamic>) {
      final sanitized = Map<String, dynamic>.from(body);

      for (final key in sanitized.keys) {
        if (key.toLowerCase().contains('token')) {
          sanitized[key] = '******';
        }
      }

      return sanitized;
    }

    return body;
  }

  /// REQUEST
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now();

    final sanitizedBody = _sanitizeRequestBody(options.path, options.data);

    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ REQUEST
╠══════════════════════════════════════════════════════════════
║ Method: ${options.method}
║ URL: ${options.baseUrl}${options.path}
║ Query: ${options.queryParameters}
║ Body:
${_prettyJson(sanitizedBody)}
╚══════════════════════════════════════════════════════════════
''');

    handler.next(options);
  }

  /// RESPONSE
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['startTime'] as DateTime?;
    final duration = startTime != null
        ? DateTime.now().difference(startTime)
        : null;

    final sanitizedBody = _sanitizeResponseBody(response.data);

    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ RESPONSE
╠══════════════════════════════════════════════════════════════
║ Status Code: ${response.statusCode}
║ Method: ${response.requestOptions.method}
║ URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}
║ Duration: ${duration?.inMilliseconds ?? '-'} ms
║ Data:
${_prettyJson(sanitizedBody)}
╚══════════════════════════════════════════════════════════════
''');

    handler.next(response);
  }

  /// ERROR
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['startTime'] as DateTime?;
    final duration = startTime != null
        ? DateTime.now().difference(startTime)
        : null;

    final sanitizedBody = _sanitizeResponseBody(err.response?.data);

    debugPrint('''
╔══════════════════════════════════════════════════════════════
║ ERROR
╠══════════════════════════════════════════════════════════════
║ Status Code: ${err.response?.statusCode}
║ Method: ${err.requestOptions.method}
║ URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}
║ Duration: ${duration?.inMilliseconds ?? '-'} ms
║ Response:
${_prettyJson(sanitizedBody)}
╚══════════════════════════════════════════════════════════════
''');

    handler.next(err);
  }
}
