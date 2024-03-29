import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/di/interceptor/app_interceptor.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:injectable/injectable.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';
const Duration _connectTimeoutDuration = Duration(seconds: 3000);
const Duration _receiveTimeoutDuration = Duration(seconds: 5000);

@Singleton()
class DioProvider {
  Dio? _dio;

  Dio getDio() {
    _dio ??= _createDio(requireAuthentication: true);
    return _dio!;
  }

  Dio _createDio({bool requireAuthentication = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(
      requireAuthentication,
      dio,
      getIt<SecureStorage>(),
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = _connectTimeoutDuration
      ..options.receiveTimeout = _receiveTimeoutDuration
      ..options.headers = {headerContentType: defaultContentType}
      ..interceptors.addAll(interceptors);
  }
}
