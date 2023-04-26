import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyAnswerTextarea extends StatefulWidget {
  const FormSurveyAnswerTextarea({super.key});

  @override
  State<FormSurveyAnswerTextarea> createState() =>
      _FormSurveyAnswerTextareaState();
}

class _FormSurveyAnswerTextareaState extends State<FormSurveyAnswerTextarea> {
  final _answerTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.answerTextAreaHeight,
      child: TextField(
        expands: true,
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.bodySmall,
        controller: _answerTextFieldController,
        decoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              hintText: AppLocalizations.of(context)!.answer_text_area_hint,
            ),
      ),
    );
  }
}
