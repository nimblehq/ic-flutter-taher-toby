import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/service/login_service.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecases/login_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/env.dart';

abstract class LoginRepository {
  Future<LoginModel> doLogin({
    required LoginInput input,
  });
}

@Singleton(as: LoginRepository)
class LoginRepositoryImpl extends LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);
  @override
  Future<LoginModel> doLogin({
    required LoginInput input,
  }) async {
    try {
      final LoginRequest loginRequest = LoginRequest(
        grantType: "password",
        email: input.email,
        password: input.password,
        clientId: Env.restApiClientId,
        clientSecret: Env.restApiClientSecret,
      );
      final response = await _loginService.doLogin(loginRequest);
      return LoginModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
