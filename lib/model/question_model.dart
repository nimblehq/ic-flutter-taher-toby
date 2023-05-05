import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/model/answer_model.dart';

class QuestionModel extends Equatable {
  final String id;
  final String text;
  final DisplayType displayType;
  final List<AnswerModel> answers;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.displayType,
    required this.answers,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        displayType,
        answers,
      ];

  factory QuestionModel.fromResponse(QuestionResponse response) {
    return QuestionModel(
      id: response.id ?? '',
      text: response.text ?? '',
      displayType: response.displayType ?? DisplayType.unknown,
      answers: (response.answers ?? [])
          .map((answer) => AnswerModel.fromResponse(answer))
          .toList(),
    );
  }
}
