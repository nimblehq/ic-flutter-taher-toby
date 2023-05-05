import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/request/refresh_token_request.dart';
import 'package:flutter_survey/api/service/authentication_service.dart';
import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/env.dart';

const String _grantTypePassword = "password";
const String _grantTypeRefreshToken = 'refresh_token';

abstract class AuthenticationRepository {
  Future<AuthTokenModel> logIn({
    required String email,
    required String password,
  });

  Future<AuthTokenModel> refreshToken({
    required String refreshToken,
  });
}

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationService _autenticationService;

  AuthenticationRepositoryImpl(this._autenticationService);

  @override
  Future<AuthTokenModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final LoginRequest loginRequest = LoginRequest(
        grantType: _grantTypePassword,
        email: email,
        password: password,
        clientId: Env.restApiClientId,
        clientSecret: Env.restApiClientSecret,
      );
      final response = await _autenticationService.logIn(loginRequest);
      return AuthTokenModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<AuthTokenModel> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(
        grantType: _grantTypeRefreshToken,
        clientId: Env.restApiClientId,
        clientSecret: Env.restApiClientSecret,
        refreshToken: refreshToken,
      );
      final response =
          await _autenticationService.refreshToken(refreshTokenRequest);
      return AuthTokenModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
