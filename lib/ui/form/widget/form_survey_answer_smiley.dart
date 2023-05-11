import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

const _emojis = ['😡', '😕', '😐', '🙂', '😄'];
final selectedEmojiProvider = StateProvider.autoDispose<String>(
  (_) => '😐',
);

class FormSurveyAnswerSmiley extends ConsumerStatefulWidget {
  final ValueChanged<List<SubmitSurveyAnswerModel>> onUpdateAnswer;
  final QuestionModel question;

  const FormSurveyAnswerSmiley({
    Key? key,
    required this.question,
    required this.onUpdateAnswer,
  }) : super(key: key);

  @override
  ConsumerState<FormSurveyAnswerSmiley> createState() =>
      _FormSurveyAnswerSmileyState();
}

class _FormSurveyAnswerSmileyState
    extends ConsumerState<FormSurveyAnswerSmiley> {
  final int defaultSelectedAnswer = 2;
  late List<String> answerIds;

  @override
  void initState() {
    super.initState();
    answerIds = widget.question.answers.map((element) => element.id).toList();
    widget.onUpdateAnswer(
      [
        SubmitSurveyAnswerModel(
          id: answerIds[defaultSelectedAnswer],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final emojiState = ref.read(selectedEmojiProvider.notifier);
    return Container(
      width: double.infinity,
      height: AppDimensions.answerSmileyHeight,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _emojis.length,
        itemBuilder: (context, index) {
          final emoji = _emojis[index];
          return GestureDetector(
            onTap: () {
              widget.onUpdateAnswer(
                [
                  SubmitSurveyAnswerModel(
                    id: answerIds[index],
                  )
                ],
              );
              emojiState.state = emoji;
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing8),
              child: _buildEmoji(emoji, ref),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmoji(String emoji, WidgetRef ref) {
    final selectedEmoji = ref.watch(selectedEmojiProvider);
    const selectedStyle = TextStyle(
      fontSize: AppDimensions.answerSmileyTextSize,
    );
    final unselectedStyle = selectedStyle.copyWith(
      color: AppColors.black50,
    );

    return Text(
      emoji,
      style: selectedEmoji == emoji ? selectedStyle : unselectedStyle,
    );
  }
}
