import 'package:json_annotation/json_annotation.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  final String? id;
  final String? text;

  AnswerResponse({
    required this.id,
    required this.text,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return _$AnswerResponseFromJson(json);
  }
}
