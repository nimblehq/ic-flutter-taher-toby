import 'package:dio/dio.dart';
import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/request/refresh_token_request.dart';
import 'package:flutter_survey/api/response/auth_response.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

abstract class AuthenticationService {
  Future<AuthResponse> logIn(@Body() LoginRequest request);
  Future<AuthResponse> getAuthToken(@Body() RefreshTokenRequest request);
}

@RestApi()
abstract class AuthenticationServiceImpl extends AuthenticationService {
  factory AuthenticationServiceImpl(Dio dio, {String baseUrl}) =
      _AuthenticationServiceImpl;

  @override
  @POST('/oauth/token')
  Future<AuthResponse> logIn(@Body() LoginRequest request);

  @override
  @POST('/oauth/token')
  Future<AuthResponse> getAuthToken(@Body() RefreshTokenRequest request);
}
