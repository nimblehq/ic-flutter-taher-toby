import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

const emojis = ['😡', '😕', '😐', '🙂', '😄'];
final selectedEmojiProvider = StateProvider.autoDispose<String>(
  (_) => '😐',
);

class FormSurveyAnswerSmiley extends ConsumerWidget {
  const FormSurveyAnswerSmiley({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiState = ref.read(selectedEmojiProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final emoji in emojis) ...[
          GestureDetector(
            onTap: () {
              emojiState.state = emoji;
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing8),
              child: buildEmoji(emoji, ref),
            ),
          ),
        ]
      ],
    );
  }

  Widget buildEmoji(String emoji, WidgetRef ref) {
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
