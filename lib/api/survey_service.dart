import 'package:dio/dio.dart';
import 'package:flutter_survey/api/response/survey_details_response.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:retrofit/retrofit.dart';

part 'survey_service.g.dart';

abstract class SurveyService {
  Future<SurveysResponse> getSurveys(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );

  Future<SurveyDetailsResponse> getSurveyDetails(
    @Path('surveyId') String surveyId,
  );
}

@RestApi()
abstract class SurveyServiceImpl extends SurveyService {
  factory SurveyServiceImpl(Dio dio, {String baseUrl}) = _SurveyServiceImpl;

  @override
  @GET('/surveys?page[number]={pageNumber}&page[size]={pageSize}')
  Future<SurveysResponse> getSurveys(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );

  @override
  @GET('/surveys/{surveyId}')
  Future<SurveyDetailsResponse> getSurveyDetails(
    @Path('surveyId') String surveyId,
  );
}
