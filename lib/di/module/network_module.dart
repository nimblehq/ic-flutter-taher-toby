import 'package:flutter_survey/api/api_service.dart';
import 'package:flutter_survey/di/provider/dio_provider.dart';
import 'package:flutter_survey/env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @Singleton(as: ApiService)
  ApiServiceImpl provideApiService(DioProvider dioProvider) {
    return ApiServiceImpl(
      dioProvider.getDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
