// ignore: unused_import
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:flutter_survey/usecases/get_auth_token_use_case.dart';
import 'package:flutter_survey/usecases/refresh_token_use_case.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/store_auth_token_use_case.dart';

const String _authorizationHeader = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthentication;
  final Dio _dio;
  final SecureStorage _secureStorage;

  AppInterceptor(
    this._requireAuthentication,
    this._dio,
    this._secureStorage,
  );

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
    super.onRequest(options, handler);
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
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final RefreshTokenUseCase refreshTokenUseCase =
          getIt.get<RefreshTokenUseCase>();
      final StoreAuthTokenUseCase storeAuthTokenUseCase =
          getIt.get<StoreAuthTokenUseCase>();
      final GetAuthTokenUseCase getAuthTokenUseCase =
          getIt.get<GetAuthTokenUseCase>();
      final AuthTokenModel authTokenModel = await getAuthTokenUseCase.call();
      final refreshTokenResult =
          await refreshTokenUseCase.call(authTokenModel.refreshToken);
      if (refreshTokenResult is Success<AuthTokenModel>) {
        AuthTokenModel authTokenModel = refreshTokenResult.value;
        final String accessToken = authTokenModel.accessToken;
        final String tokenType = authTokenModel.tokenType;
        storeAuthTokenUseCase.call(authTokenModel);
        error.requestOptions.headers[_authorizationHeader] =
            '$tokenType $accessToken';
        final options = Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        );
        final newRequest = await _dio.request(
          "${error.requestOptions.baseUrl}${error.requestOptions.path}",
          options: options,
          data: error.requestOptions.data,
          queryParameters: error.requestOptions.queryParameters,
        );
        handler.resolve(newRequest);
      } else {
        handler.next(error);
      }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(error);
      }
    }
  }
}
