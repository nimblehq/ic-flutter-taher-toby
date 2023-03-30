import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';

class SurveyModel extends Equatable {
  final String id;
  final String title;

  const SurveyModel({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];

  factory SurveyModel.fromResponse(SurveyResponse response) {
    return SurveyModel(id: response.id ?? "", title: response.title ?? "");
  }
}
