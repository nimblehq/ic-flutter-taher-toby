import 'package:dio/dio.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/usecases/get_cached_surveys_use_case.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetCachedSurveysUseCase,
  GetSurveysUseCase,
  SurveyService,
  SurveyStorage,
  SurveyRepository,
  DioError,
])
main() {}
