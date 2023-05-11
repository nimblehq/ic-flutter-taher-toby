import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_answer_request.g.dart';

@JsonSerializable()
class SubmitSurveyAnswerRequest {
  final String id;
  final String answer;

  SubmitSurveyAnswerRequest({
    required this.id,
    required this.answer,
  });

  factory SubmitSurveyAnswerRequest.fromModel(SubmitSurveyAnswerModel model) {
    return SubmitSurveyAnswerRequest(
      id: model.id,
      answer: model.answer ?? '',
    );
  }

  factory SubmitSurveyAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyAnswerRequestToJson(this);
}
