import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';

class QuestionModel extends Equatable {
  final String id;
  final String text;

  const QuestionModel({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [
        id,
        text,
      ];

  factory QuestionModel.fromResponse(QuestionResponse response) {
    return QuestionModel(
      id: response.id ?? '',
      text: response.text ?? '',
    );
  }
}
