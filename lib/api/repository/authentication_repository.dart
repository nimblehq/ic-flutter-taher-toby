import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/service/authentication_service.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/env.dart';

abstract class AuthenticationRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

@Singleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationService _autenticationService;

  AuthenticationRepositoryImpl(this._autenticationService);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final LoginRequest loginRequest = LoginRequest(
        grantType: grantType,
        email: email,
        password: password,
        clientId: Env.restApiClientId,
        clientSecret: Env.restApiClientSecret,
      );
      final response = await _autenticationService.login(loginRequest);
      return LoginModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
