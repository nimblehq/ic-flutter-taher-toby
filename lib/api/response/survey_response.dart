import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  String? id;
  String? title;
  String? description;
  String? coverImageUrl;

  SurveyResponse({
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyResponseFromJson(json);
  }

  String getHdCoverImageUrl() {
    if (coverImageUrl != null) {
      return "${coverImageUrl}l";
    } else {
      return "";
    }
  }
}
