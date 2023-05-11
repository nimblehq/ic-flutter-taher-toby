import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerTextarea extends StatefulWidget {
  final ValueChanged<List<SubmitSurveyAnswerModel>> onUpdateText;
  final QuestionModel question;

  const FormSurveyAnswerTextarea({
    super.key,
    required this.question,
    required this.onUpdateText,
  });

  @override
  State<FormSurveyAnswerTextarea> createState() =>
      _FormSurveyAnswerTextareaState();
}

class _FormSurveyAnswerTextareaState extends State<FormSurveyAnswerTextarea> {
  late String _ansTextId;

  @override
  void initState() {
    super.initState();
    _ansTextId = widget.question.answers.first.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.answerTextareaHeight,
      child: TextField(
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.bodySmall,
        controller: null,
        onChanged: (text) {
          widget.onUpdateText(
            [
              SubmitSurveyAnswerModel(
                id: _ansTextId,
                answer: text,
              )
            ],
          );
        },
        decoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              hintText: AppLocalizations.of(context)!.answer_text_area_hint,
            ),
      ),
    );
  }
}
