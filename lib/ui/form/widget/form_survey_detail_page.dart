import 'package:flutter/material.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';

class FormSurveyDetailPage extends StatelessWidget {
  final SurveyDetailsModel surveyDetails;

  const FormSurveyDetailPage({
    Key? key,
    required this.surveyDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppDimensions.spacing20),
        const BackButton(color: Colors.white),
        const SizedBox(height: AppDimensions.spacing10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing20,
          ),
          child: Text(
            surveyDetails.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing20,
          ),
          child: Text(
            surveyDetails.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white70,
                ),
          ),
        ),
      ],
    );
  }
}
