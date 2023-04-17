import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_details_response.g.dart';

@JsonSerializable()
class SurveyDetailsResponse {
  String? id;
  String? title;
  String? description;
  String? coverImageUrl;

  SurveyDetailsResponse({
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
  });

  factory SurveyDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyDetailsResponseFromJson(json);
  }

  String getHdCoverImageUrl() {
    if (coverImageUrl != null) {
      return "${coverImageUrl}l";
    } else {
      return "";
    }
  }
}
