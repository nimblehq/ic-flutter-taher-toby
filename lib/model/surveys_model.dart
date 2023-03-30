import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_survey/model/survey_model.dart';

class SurveysModel extends Equatable {
  final List<SurveyModel> surveys;

  const SurveysModel({
    required this.surveys,
  });

  @override
  List<Object?> get props => [surveys];

  factory SurveysModel.fromResponse(SurveysResponse response) {
    final surveyList = response.surveys ?? List.empty();
    return SurveysModel(
        surveys: surveyList
            .map((survey) => SurveyModel.fromResponse(survey))
            .toList());
  }
}
