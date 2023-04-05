import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_response.dart';

class SurveyModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  const SurveyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, coverImageUrl];

  factory SurveyModel.fromResponse(SurveyResponse response) {
    return SurveyModel(
      id: response.id ?? "",
      title: response.title ?? "",
      description: response.description ?? "",
      coverImageUrl: response.getHdCoverImageUrl(),
    );
  }
}
