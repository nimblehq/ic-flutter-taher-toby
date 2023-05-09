import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/model/text_answer_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerTextarea extends StatefulWidget {
  final ValueChanged<List<TextAnswerModel>> onUpdateText;
  final String answerId;

  const FormSurveyAnswerTextarea({
    super.key,
    required this.answerId,
    required this.onUpdateText,
  });

  @override
  State<FormSurveyAnswerTextarea> createState() =>
      _FormSurveyAnswerTextareaState();
}

class _FormSurveyAnswerTextareaState extends State<FormSurveyAnswerTextarea> {
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
              TextAnswerModel(
                answerId: widget.answerId,
                answerText: text,
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
