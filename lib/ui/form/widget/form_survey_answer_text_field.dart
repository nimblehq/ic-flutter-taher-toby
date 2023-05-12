import 'package:collection/collection.dart';
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
        children: widget.answers
            .mapIndexed(
              (index, element) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimensions.spacing20),
                child: customTextField(
                  context: context,
                  controller: null,
                  textInputType: widget.answers[index].text == 'Email'
                      ? TextInputType.emailAddress
                      : TextInputType.text,
                  isObscuredText: false,
                  hintText: widget.answers[index].text,
                  onChanged: (text) {
                    _answerModels[index] = SubmitSurveyAnswerModel(
                      id: _answerModels[index].id,
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
