import 'package:flutter/material.dart';
import 'package:flutter_survey/model/answer_model.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/custom_text_field.dart';

class FormSurveyAnswerTextField extends StatefulWidget {
  final List<AnswerModel> answers;
  final ValueChanged<List<SubmitSurveyAnswerModel>> onUpdateAnswer;

  const FormSurveyAnswerTextField({
    super.key,
    required this.answers,
    required this.onUpdateAnswer,
  });

  @override
  State<FormSurveyAnswerTextField> createState() =>
      _FormSurveyAnswerTextFieldState();
}

class _FormSurveyAnswerTextFieldState extends State<FormSurveyAnswerTextField> {
  late List<SubmitSurveyAnswerModel> _answerModels = [];

  @override
  void initState() {
    super.initState();
    _answerModels = widget.answers
        .map((element) => SubmitSurveyAnswerModel(
              id: element.id,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _answerModels
            .asMap()
            .entries
            .map(
              (answerEntry) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacing20),
                child: customTextField(
                  context: context,
                  controller: null,
                  textInputType: widget.answers[answerEntry.key].text == 'Email'
                      ? TextInputType.emailAddress
                      : TextInputType.text,
                  isObscuredText: false,
                  hintText: widget.answers[answerEntry.key].text,
                  onChanged: (text) {
                    _answerModels[answerEntry.key] = SubmitSurveyAnswerModel(
                      id: _answerModels[answerEntry.key].id,
                      answer: text,
                    );
                    widget.onUpdateAnswer(_answerModels);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
