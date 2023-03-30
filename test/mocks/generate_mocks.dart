import 'package:dio/dio.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/survey_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  SurveyService,
  SurveyRepository,
  DioError,
])
main() {}
