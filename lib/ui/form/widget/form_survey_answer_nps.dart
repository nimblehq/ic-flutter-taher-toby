import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSurveyAnswerNps extends ConsumerStatefulWidget {
  final ValueChanged<List<int>> onSelectedAnswer;
  final QuestionModel question;

  const FormSurveyAnswerNps({
    Key? key,
    required this.question,
    required this.onSelectedAnswer,
  }) : super(key: key);

  @override
  FormSurveyAnswerNpsState createState() {
    return FormSurveyAnswerNpsState();
  }
}

class FormSurveyAnswerNpsState extends ConsumerState<FormSurveyAnswerNps> {
  final selectedScoreProvider = StateProvider.autoDispose<int>((_) => 0);
  late int scoresLength;

  @override
  void initState() {
    super.initState();
    scoresLength = widget.question.answers.length;
    final int defaultSelectedAnswer = (scoresLength / 2).floor();
    ref.read(selectedScoreProvider.notifier).state = defaultSelectedAnswer;
    widget.onSelectedAnswer([defaultSelectedAnswer]);
  }

  @override
  Widget build(BuildContext context) {
    final scores = List.generate(scoresLength, (index) => index);
    final scoreState = ref.read(selectedScoreProvider.notifier);
    final selectedScore = ref.watch(selectedScoreProvider);
    final selectedStyle = Theme.of(context).textTheme.labelSmall;
    final unselectedStyle = selectedStyle?.copyWith(color: AppColors.white50);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: AppDimensions.answerNpsHeight,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: AppDimensions.answerNpsBorderWidth,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.radius10),
                ),
              ),
              child: Row(
                children: List.generate(scoresLength, (index) {
                  final score = scores[index];
                  return GestureDetector(
                    onTap: () {
                      scoreState.state = score;
                      widget.onSelectedAnswer([index]);
                    },
                    child: _buildScore(context, ref, score, scoresLength),
                  );
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimensions.spacing18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.not_at_all_likely,
                style: selectedScore <= scoresLength / 2
                    ? selectedStyle
                    : unselectedStyle,
              ),
              Text(
                AppLocalizations.of(context)!.extremely_likely,
                style: selectedScore > scoresLength / 2
                    ? selectedStyle
                    : unselectedStyle,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildScore(
    BuildContext context,
    WidgetRef ref,
    int score,
    int scoresLength,
  ) {
    final selectedScore = ref.watch(selectedScoreProvider);
    final selectedStyle = Theme.of(context).textTheme.labelMedium;
    final unselectedStyle = selectedStyle?.copyWith(color: AppColors.white50);

    Border? border;
    if (score < scoresLength) {
      border = const Border(
        right: BorderSide(
          color: Colors.white,
          width: AppDimensions.answerNpsBorderWidth,
        ),
      );
    }

    return Container(
      width: AppDimensions.answerNpsWidth,
      decoration: BoxDecoration(border: border),
      child: Center(
        child: Text(
          score.toString(),
          style: selectedScore >= score ? selectedStyle : unselectedStyle,
        ),
      ),
    );
  }
}
