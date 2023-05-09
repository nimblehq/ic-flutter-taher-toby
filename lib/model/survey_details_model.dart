import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/api/response/survey_details_response.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:collection/collection.dart';

class SurveyDetailsModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<QuestionModel> questions;
  final String intro;
  final String outro;

  const SurveyDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
    required this.intro,
    required this.outro,
  });

  @override
  List<Object?> get props => [id, title, description, coverImageUrl, questions];

  factory SurveyDetailsModel.fromResponse(SurveyDetailsResponse response) {
    return SurveyDetailsModel(
      id: response.id ?? "",
      title: response.title ?? "",
      description: response.description ?? "",
      coverImageUrl: response.getHdCoverImageUrl(),
      questions: (response.questions ?? [])
          .map((question) => QuestionModel.fromResponse(question))
          .where(
            (element) =>
                element.displayType != DisplayType.intro &&
                element.displayType != DisplayType.outro,
          )
          .toList(),
      intro: (response.questions ?? [])
              .firstWhereOrNull(
                  (question) => question.displayType == DisplayType.intro)
              ?.text ??
          '',
      outro: (response.questions ?? [])
              .firstWhereOrNull(
                  (question) => question.displayType == DisplayType.outro)
              ?.text ??
          '',
    );
  }
}
