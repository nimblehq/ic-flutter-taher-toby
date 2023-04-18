// ignore: unused_import
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_survey/database/secure_storage.dart';

const String _authorizationHeader = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthentication;
  final Dio _dio;
  final SecureStorage _secureStorage;

  AppInterceptor(this._requireAuthentication, this._dio, this._secureStorage);

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthentication) {
      final String accessToken =
          await _secureStorage.readSecureData(accessTokenKey) ?? '';
      final String tokenType =
          await _secureStorage.readSecureData(tokenTypeKey) ?? '';
      options.headers
          .putIfAbsent(_authorizationHeader, () => '$tokenType $accessToken');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
    // TODO: Integrate refresh-token https://github.com/nimblehq/ic-flutter-taher-toby/issues/20
    // final statusCode = err.response?.statusCode;
    // if ((statusCode == HttpStatus.forbidden ||
    //         statusCode == HttpStatus.unauthorized) &&
    //     _requireAuthentication) {
    //   _doRefreshToken(err, handler);
    // } else {
    // }
  }

  // ignore: unused_element
  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // if (result is Success) {
      // err.requestOptions.headers[_headerAuthorization] = newToken;
      // Create request with new access token
      final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers);
      final newRequest = await _dio.request(
          "${err.requestOptions.baseUrl}${err.requestOptions.path}",
          options: options,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters);
      handler.resolve(newRequest);
      //  } else {
      //    handler.next(err);
      //  }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(err);
      }
    }
  }
}
