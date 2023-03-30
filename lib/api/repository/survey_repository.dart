import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/surveys_model.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<SurveysModel> getSurveys(
      {required int pageNumber, required int pageSize});
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<SurveysModel> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await _surveyService.getSurveys(pageNumber, pageSize);
      return SurveysModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
