import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';

class QuestionModel extends Equatable {
  final String id;
  final String text;
  final DisplayType displayType;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.displayType,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayType,
      ];

  factory QuestionModel.fromResponse(QuestionResponse response) {
    return QuestionModel(
      id: response.id ?? '',
      text: response.text ?? '',
      displayType: response.displayType ?? DisplayType.unknown,
    );
  }
}
