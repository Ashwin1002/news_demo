import 'dart:developer' show log;

import 'package:dio/dio.dart';
import 'package:news_demo/core/core.dart';

class AuthInterceptor extends Interceptor {
  final bool isTokenRequired;

  AuthInterceptor({required this.isTokenRequired});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token = isTokenRequired ? sl<EnvHelper>().get('API_KEY') : '';

    log('token => $token');
    if (token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => token);
    }

    log('base url => ${options.uri}}');
    super.onRequest(options, handler);
  }
}
