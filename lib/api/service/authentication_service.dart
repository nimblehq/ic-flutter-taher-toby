import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/request/refresh_token_request.dart';
import 'package:flutter_survey/api/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

abstract class AuthenticationService {
  Future<LoginResponse> logIn(@Body() LoginRequest request);
  Future<LoginResponse> getAuthToken(@Body() RefreshTokenRequest request);
}

@RestApi()
abstract class AuthenticationServiceImpl extends AuthenticationService {
  factory AuthenticationServiceImpl(Dio dio, {String baseUrl}) =
      _AuthenticationServiceImpl;

  @override
  @POST('/oauth/token')
  Future<LoginResponse> logIn(@Body() LoginRequest request);

  @override
  @POST('/oauth/token')
  Future<LoginResponse> getAuthToken(@Body() RefreshTokenRequest request);
}
