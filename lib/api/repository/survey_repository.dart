import 'package:flutter_survey/api/survey_service.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/database/survey_storage.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:injectable/injectable.dart';

abstract class SurveyRepository {
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  });

  Future<SurveyDetailsModel> getSurveyDetails({
    required String surveyId,
  });
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final SurveyService _surveyService;
  final SurveyStorage _surveyStorage;

  SurveyRepositoryImpl(
    this._surveyService,
    this._surveyStorage,
  );

  @override
  Future<List<SurveyModel>> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final response = await _surveyService.getSurveys(pageNumber, pageSize);
      final surveys = response.surveys ?? [];
      final surveyModels =
          surveys.map((item) => SurveyModel.fromResponse(item)).toList();
      _surveyStorage.saveSurveys(surveyModels);
      return surveyModels;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyDetailsModel> getSurveyDetails({
    required String surveyId,
  }) async {
    try {
      final response = await _surveyService.getSurveyDetails(surveyId);
      return SurveyDetailsModel.fromResponse(response);
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
