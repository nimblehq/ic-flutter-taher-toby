import 'package:flutter_survey/api/service/authentication_service.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/di/provider/dio_provider.dart';
import 'package:flutter_survey/env.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @Singleton(as: SurveyService)
  SurveyServiceImpl provideSurveyService(DioProvider dioProvider) {
    return SurveyServiceImpl(
      dioProvider.getDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }

  @Singleton(as: AuthenticationService)
  AuthenticationServiceImpl provideAuthenticationService(DioProvider dioProvider) {
    return AuthenticationServiceImpl(
      dioProvider.getDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
