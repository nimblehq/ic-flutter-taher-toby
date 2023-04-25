import 'package:json_annotation/json_annotation.dart';

part 'question_response.g.dart';

enum DisplayType {
  intro,
  choice,
  dropdown,
  heart,
  nps,
  outro,
  smiley,
  star,
  textarea,
  textfield,
  thumbs,
  unknown
}

@JsonSerializable()
class QuestionResponse {
  final String? id;
  final String? text;
  final DisplayType? displayType;

  QuestionResponse({
    required this.id,
    required this.text,
    required this.displayType,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return _$QuestionResponseFromJson(json);
  }
}
