import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_survey/di/interceptor/app_interceptor.dart';
import 'package:flutter_survey/utils/storage/secure_storage.dart';
import 'package:injectable/injectable.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

@Singleton()
class DioProvider {
  Dio? _dio;

  Dio getDio() {
    _dio ??= _createDio(requireAuthentication: true);
    return _dio!;
  }

  Dio _createDio({bool requireAuthentication = false}) {
    final dio = Dio();
    final SecureStorage secureStorage = SecureStorage();
    final appInterceptor =
        AppInterceptor(requireAuthentication, dio, secureStorage);
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
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {headerContentType: defaultContentType}
      ..interceptors.addAll(interceptors);
  }
}
