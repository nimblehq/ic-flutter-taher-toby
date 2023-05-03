import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/answer_response.dart';

class AnswerModel extends Equatable {
  final String id;
  final String text;

  const AnswerModel({
    required this.id,
    required this.text,
  });

  @override
  List<Object?> get props => [id, text];

  factory AnswerModel.fromResponse(AnswerResponse response) {
    return AnswerModel(
      id: response.id ?? '',
      text: response.text ?? '',
    );
  }
}
