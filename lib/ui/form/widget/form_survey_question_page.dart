import 'package:flutter/material.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_nps.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_smiley.dart';

class FormSurveyQuestionPage extends StatelessWidget {
  final QuestionModel question;
  final int questionIndex;
  final int questionTotal;

  const FormSurveyQuestionPage({
    Key? key,
    required this.question,
    required this.questionIndex,
    required this.questionTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacing54,
          horizontal: AppDimensions.spacing16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionCounter(context),
            const SizedBox(height: AppDimensions.spacing8),
            _buildQuestion(context),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: _buildAnswer(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCounter(BuildContext context) => Text(
        "$questionIndex/$questionTotal",
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: AppColors.white50),
      );

  Widget _buildQuestion(BuildContext context) => Text(
        question.text,
        style: Theme.of(context).textTheme.titleLarge,
      );

  Widget _buildAnswer(BuildContext context) {
    final displayType = question.displayType;
    switch (displayType) {
      case DisplayType.smiley:
        return const FormSurveyAnswerSmiley();
      case DisplayType.nps:
        return FormSurveyAnswerNps(
          question: question,
        );
      default:
        return Text(displayType.name);
    }
  }
}
