import 'package:flutter/material.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/next_button.dart';

const _surveyTitleMaxLines = 2;
const _surveyDescriptionMaxLines = 2;

class HomeSurveyPage extends StatelessWidget {
  final SurveyModel survey;
  final VoidCallback onNextButtonPressed;

  const HomeSurveyPage({
    Key? key,
    required this.survey,
    required this.onNextButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DimmedBackground(background: survey.coverImageUrl),
        Padding(
          padding: const EdgeInsets.only(
              left: AppDimensions.spacing20,
              bottom: AppDimensions.spacing54,
              right: AppDimensions.spacing20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      survey.title,
                      style: Theme.of(context).textTheme.displayLarge,
                      maxLines: _surveyTitleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.spacing16),
                    Text(
                      survey.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white70,
                          ),
                      maxLines: _surveyDescriptionMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              NextButton(
                onNextButtonPressed: onNextButtonPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
