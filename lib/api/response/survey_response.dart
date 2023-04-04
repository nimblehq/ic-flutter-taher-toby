import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  String? id;
  String? title;

  SurveyResponse({
    this.id,
    this.title,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyResponseFromJson(json);
  }
}
