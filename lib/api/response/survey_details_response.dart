import 'package:flutter_survey/api/response/decoder/response_decoder.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_details_response.g.dart';

@JsonSerializable()
class SurveyDetailsResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? coverImageUrl;
  final List<QuestionResponse>? questions;

  SurveyDetailsResponse({
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
    this.questions
  });

  factory SurveyDetailsResponse.fromJson(Map<String, dynamic> json) {
    final decodedJson = decodeJsonFromData(json);
    return _$SurveyDetailsResponseFromJson(decodedJson);
  }

  String getHdCoverImageUrl() {
    if (coverImageUrl != null) {
      return "${coverImageUrl}l";
    } else {
      return "";
    }
  }
}
