import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSurveyDetailPage extends StatelessWidget {
  const FormSurveyDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BackButton(color: Colors.white),
        const SizedBox(height: AppDimensions.spacing10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing20,
          ),
          // TODO: Integrate title from survey details #23
          child: Text(
            "Working from home Check-In",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing20,
          ),
          child: Text(
            // TODO: Integrate description from survey details #23
            "We would like to know how you feel about our work from home (WFH) experience.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white70,
                ),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing20,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Integrate click-event from survey details #23
              },
              child: Text(
                AppLocalizations.of(context)!.start_survey,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacing16),
      ],
    );
  }
}
