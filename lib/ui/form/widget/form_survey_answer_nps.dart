import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const _scores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class FormSurveyAnswerNps extends ConsumerWidget {
  final selectedScoreProvider = StateProvider.autoDispose<int>(
    (_) => 5,
  );

  FormSurveyAnswerNps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                children: List.generate(_scores.length, (index) {
                  final score = _scores[index];
                  return GestureDetector(
                    onTap: () => scoreState.state = score,
                    child: _buildScore(context, ref, score),
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
                style: selectedScore <= 5 ? selectedStyle : unselectedStyle,
              ),
              Text(
                AppLocalizations.of(context)!.extremely_likely,
                style: selectedScore > 5 ? selectedStyle : unselectedStyle,
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
  ) {
    final selectedScore = ref.watch(selectedScoreProvider);
    final selectedStyle = Theme.of(context).textTheme.labelMedium;
    final unselectedStyle = selectedStyle?.copyWith(color: AppColors.white50);

    dynamic border;
    if (score < 10) {
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
