import 'dart:io';

import 'package:dio/dio.dart';

const String _authorizationHeader = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthentication;
  final Dio _dio;

  AppInterceptor(
    this._requireAuthentication,
    this._dio,
  );

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthentication) {
      // TODO: Integrate log-in https://github.com/nimblehq/ic-flutter-taher-toby/issues/10
      options.headers.putIfAbsent(_authorizationHeader, () => "Bearer add your token here");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthentication) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // TODO Request new token

      // if (result is Success) {
      // TODO Update new token header
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
