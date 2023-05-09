import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:lottie/lottie.dart';

class FormSurveyCompletionPage extends StatefulWidget {
  const FormSurveyCompletionPage({super.key});

  @override
  State<FormSurveyCompletionPage> createState() => _FormSurveyCompletionPageState();
}

class _FormSurveyCompletionPageState extends State<FormSurveyCompletionPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacing24),
      color: AppColors.blackRussian,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox.shrink()),
          Lottie.asset(
            Assets.animations.surveyCompletion,
            width: AppDimensions.surveyCompletionAnimationSize,
            height: AppDimensions.surveyCompletionAnimationSize,
            fit: BoxFit.fill,
            controller: _animationController,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..forward();
            },
          ),
          Text(
            AppLocalizations.of(context)!.thank_you_survey,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
