import 'package:dio/dio.dart';
import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_cached_surveys_use_case.dart';
import 'package:flutter_survey/api/service/authentication_service.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/usecases/auth_token_storage_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetCachedSurveysUseCase,
  GetSurveyDetailsUseCase,
  GetSurveysUseCase,
  SurveyService,
  SurveyStorage,
  SurveyRepository,
  LogInUseCase,
  AuthTokenStorageUseCase,
  AuthenticationService,
  AuthenticationRepository,
  SecureStorage,
  UseCaseException,
  DioError,
])
main() {}
