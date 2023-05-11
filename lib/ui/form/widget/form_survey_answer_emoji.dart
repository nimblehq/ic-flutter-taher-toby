import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/model/submit_answer_model.dart';

class FormSurveyAnswerEmoji extends ConsumerStatefulWidget {
  final ValueChanged<List<SubmitAnswerModel>> onUpdateAnswer;
  final QuestionModel question;
  final String emoji;
  final int totalEmojiCount;

  const FormSurveyAnswerEmoji({
    Key? key,
    required this.emoji,
    this.totalEmojiCount = 5,
    required this.onUpdateAnswer,
    required this.question,
  }) : super(key: key);

  @override
  ConsumerState<FormSurveyAnswerEmoji> createState() =>
      _FormSurveyAnswerEmojiState();
}

class _FormSurveyAnswerEmojiState extends ConsumerState<FormSurveyAnswerEmoji> {
  final int defaultSelectedAnswer = 2;
  late List<String> _answerIds;
  final _selectedEmojiRatingIndexProvider = StateProvider.autoDispose<int>(
    (_) => 2,
  );

  @override
  void initState() {
    super.initState();
    _answerIds = widget.question.answers.map((element) => element.id).toList();
    widget.onUpdateAnswer(
      [
        SubmitAnswerModel(
          answerId: _answerIds[defaultSelectedAnswer],
          answerText: null,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final emojiState = ref.read(_selectedEmojiRatingIndexProvider.notifier);

    return Container(
      width: double.infinity,
      height: AppDimensions.answerEmojiHeight,
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.totalEmojiCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              emojiState.state = index;
              widget.onUpdateAnswer(
                [
                  SubmitAnswerModel(
                    answerId: _answerIds[index],
                    answerText: null,
                  )
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing8),
              child: _buildEmoji(index, ref),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmoji(int index, WidgetRef ref) {
    final selectedEmoji = ref.watch(_selectedEmojiRatingIndexProvider);
    const selectedStyle = TextStyle(
      fontSize: AppDimensions.answerEmojiTextSize,
    );
    final unselectedStyle = selectedStyle.copyWith(
      color: AppColors.black50,
    );

    return Text(
      widget.emoji,
      style: index <= selectedEmoji ? selectedStyle : unselectedStyle,
    );
  }
}
