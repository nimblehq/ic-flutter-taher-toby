import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/survey_details_response.dart';

class SurveyDetailsModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  const SurveyDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [id, title, description, coverImageUrl];

  factory SurveyDetailsModel.fromResponse(SurveyDetailsResponse response) {
    return SurveyDetailsModel(
      id: response.id ?? "",
      title: response.title ?? "",
      description: response.description ?? "",
      coverImageUrl: response.getHdCoverImageUrl(),
    );
  }
}
