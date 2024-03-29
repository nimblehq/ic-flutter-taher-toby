import 'package:flutter/material.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_multi_choice.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_nps.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_dropdown.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_emoji.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_smiley.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_text_field.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_answer_textarea.dart';

class FormSurveyQuestionPage extends StatelessWidget {
  final ValueChanged<List<SubmitSurveyAnswerModel>> onUpdatedAnswers;
  final QuestionModel question;
  final int questionIndex;
  final int questionTotal;

  const FormSurveyQuestionPage({
    Key? key,
    required this.question,
    required this.questionIndex,
    required this.questionTotal,
    required this.onUpdatedAnswers,
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
    if (question.answers.isEmpty) {
      return const SizedBox.shrink();
    }
    final displayType = question.displayType;
    switch (displayType) {
      case DisplayType.smiley:
        return FormSurveyAnswerSmiley(
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.nps:
        return FormSurveyAnswerNps(
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.heart:
        return FormSurveyAnswerEmoji(
          emoji: '❤',
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.star:
        return FormSurveyAnswerEmoji(
          emoji: '⭐',
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.thumbs:
        return FormSurveyAnswerEmoji(
          emoji: '👍🏻',
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.textarea:
        return FormSurveyAnswerTextarea(
          answer: question.answers.first,
          onUpdateText: (answer) {
            onUpdatedAnswers([answer]);
          },
        );

      case DisplayType.dropdown:
        return FormSurveyAnswerDropdown(
          answers: question.answers,
          onUpdateAnswer: (selectedAnswer) {
            onUpdatedAnswers([selectedAnswer]);
          },
        );

      case DisplayType.choice:
        return FormSurveyAnswerMultiChoice(
          answers: question.answers,
          onUpdateAnswer: (selectedAnswers) {
            onUpdatedAnswers(selectedAnswers);
          },
        );

      case DisplayType.textfield:
        return FormSurveyAnswerTextField(
          answers: question.answers,
          onUpdateAnswer: (answers) {
            onUpdatedAnswers(answers);
          },
        );

      default:
        return Text(displayType.name);
    }
  }
}
