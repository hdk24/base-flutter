import 'package:base_flutter/src/core/configs/build_config.dart';
import 'package:base_flutter/src/core/di/injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkModule {
  static void load() {
    injector.registerLazySingleton(() {
      // authorization interceptor
      final tokenInterceptor = InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) {
          // add interceptor like token authorization to headers
          return handler.next(options);
        },
      );

      // log interceptor
      final logInterceptor = LogInterceptor(
        requestBody: kDebugMode,
        responseBody: kDebugMode,
      );

      return Dio()
        ..options.baseUrl = BuildConfig.BASE_API
        ..options.connectTimeout = const Duration(seconds: 7)
        ..options.receiveTimeout = const Duration(seconds: 7)
        ..options.headers = {'content-type': Headers.jsonContentType}
        ..interceptors.add(tokenInterceptor)
        ..interceptors.add(logInterceptor);
    });
  }
}
