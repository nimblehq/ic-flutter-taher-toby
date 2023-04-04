import 'package:flutter_survey/api/response/decoder/response_decoder.dart';
import 'package:flutter_survey/api/response/survey_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  @JsonKey(name: 'data')
  List<SurveyResponse>? surveys;

  SurveysResponse({
    this.surveys,
  });

  factory SurveysResponse.fromJson(Map<String, dynamic> json) {
    final decodedJson = decodeJson(json);
    return _$SurveysResponseFromJson(decodedJson);
  }
}
