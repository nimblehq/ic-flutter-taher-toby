import 'package:json_annotation/json_annotation.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  final String? id;
  final String? text;

  QuestionResponse({
    required this.id,
    required this.text,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return _$QuestionResponseFromJson(json);
  }
}
