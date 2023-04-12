import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

abstract class AuthenticationService {
  Future<LoginResponse> login(@Body() LoginRequest request);
}

@RestApi()
abstract class AuthenticationServiceImpl extends AuthenticationService {
  factory AuthenticationServiceImpl(Dio dio, {String baseUrl}) =
      _AuthenticationServiceImpl;

  @override
  @POST('/oauth/token')
  Future<LoginResponse> login(@Body() LoginRequest request);
}
