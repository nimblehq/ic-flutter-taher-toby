import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  });
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await _surveyService.getSurveys(pageNumber, pageSize);
      final surveys = response.surveys ?? [];
      return surveys.map((item) => SurveyModel.fromResponse(item)).toList();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
