import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/service/login_service.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:injectable/injectable.dart';

abstract class LoginRepository {
  Future<LoginModel> doLogin({
    required LoginRequest request,
  });
}

@Singleton(as: LoginRepository)
class LoginRepositoryImpl extends LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);
  @override
  Future<LoginModel> doLogin({
    required LoginRequest request,
  }) async {
    try {
      final response = await _loginService.doLogin(request);
      return LoginModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
