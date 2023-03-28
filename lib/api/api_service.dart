import 'package:dio/dio.dart';
import 'package:flutter_survey/model/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

abstract class ApiService {
  Future<List<UserResponse>> getUsers();
}

@RestApi()
abstract class ApiServiceImpl extends ApiService {
  factory ApiServiceImpl(Dio dio, {String baseUrl}) = _ApiServiceImpl;

  @override
  @GET('/users')
  Future<List<UserResponse>> getUsers();
}
