import 'package:dio/dio.dart';
import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_cached_surveys_use_case.dart';
import 'package:flutter_survey/api/service/authentication_service.dart';
import 'package:flutter_survey/usecases/is_logged_in_use_case.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/usecases/store_auth_token_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/submit_survey_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetCachedSurveysUseCase,
  GetSurveyDetailsUseCase,
  GetSurveysUseCase,
  SubmitSurveyUseCase,
  SurveyService,
  SurveyStorage,
  SurveyRepository,
  LogInUseCase,
  IsLoggedInUseCase,
  StoreAuthTokenUseCase,
  AuthenticationService,
  AuthenticationRepository,
  SecureStorage,
  UseCaseException,
  DioError,
])
main() {}
