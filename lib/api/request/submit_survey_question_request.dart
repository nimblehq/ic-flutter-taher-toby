import 'package:flutter_survey/api/request/submit_survey_answer_request.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_question_request.g.dart';

@JsonSerializable()
class SubmitSurveyQuestionRequest {
  final String id;
  final List<SubmitSurveyAnswerRequest> answers;

  SubmitSurveyQuestionRequest({
    required this.id,
    required this.answers,
  });

  factory SubmitSurveyQuestionRequest.fromModel(
      SubmitSurveyQuestionModel model) {
    return SubmitSurveyQuestionRequest(
      id: model.id,
      answers: model.answers
          .map((answer) => SubmitSurveyAnswerRequest.fromModel(answer))
          .toList(),
    );
  }

  factory SubmitSurveyQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyQuestionRequestToJson(this);
}
