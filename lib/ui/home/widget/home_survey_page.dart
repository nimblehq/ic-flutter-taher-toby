import 'package:flutter/material.dart';
import 'package:flutter_survey/constants.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/next_button.dart';

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
                      maxLines: Constants.surveyTitleMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.spacing16),
                    Text(
                      survey.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(
                              Constants.surveyDescriptionOpacity,
                            ),
                          ),
                      maxLines: Constants.surveyDescriptionMaxLines,
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
