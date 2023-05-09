import 'package:flutter/material.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/custom_text_field.dart';
import 'package:flutter_survey/model/text_answer_model.dart';

class FormSurveyAnswerTextField extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<List<TextAnswerModel>> onUpdateText;

  const FormSurveyAnswerTextField({
    super.key,
    required this.question,
    required this.onUpdateText,
  });

  @override
  State<FormSurveyAnswerTextField> createState() =>
      _FormSurveyAnswerTextFieldState();
}

class _FormSurveyAnswerTextFieldState extends State<FormSurveyAnswerTextField> {
  late List<String> _textFieldHints = [];
  late List<TextAnswerModel> _answerModels = [];

  @override
  void initState() {
    super.initState();
    _textFieldHints =
        widget.question.answers.map((element) => element.text).toList();
    _answerModels = widget.question.answers
        .map((element) => TextAnswerModel(
              answerId: element.id,
              answerText: '',
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int index = 0; index < _answerModels.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacing20),
              child: customTextField(
                context: context,
                controller: null,
                textInputType: _textFieldHints[index] == 'Email'
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                isObscuredText: false,
                hintText: _textFieldHints[index],
                onChanged: (text) {
                  _answerModels[index] = TextAnswerModel(
                    answerId: _answerModels[index].answerId,
                    answerText: text,
                  );
                  widget.onUpdateText(_answerModels);
                },
              ),
            ),
        ],
      ),
    );
  }
}
