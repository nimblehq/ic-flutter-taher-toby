import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'login_service.g.dart';

abstract class LoginService {
  Future<LoginResponse> doLogin(@Body() LoginRequest request);
}

@RestApi()
abstract class LoginServiceImpl extends LoginService {
  factory LoginServiceImpl(Dio dio, {String baseUrl}) = _LoginServiceImpl;

  @override
  @POST('/oauth/token')
  Future<LoginResponse> doLogin(@Body() LoginRequest request);
}
