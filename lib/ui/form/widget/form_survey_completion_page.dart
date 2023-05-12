import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:lottie/lottie.dart';

const _surveyCompletionPageDurationInSeconds = 2;

class FormSurveyCompletionPage extends StatefulWidget {
  final String? outroMessage;

  const FormSurveyCompletionPage({
    super.key,
    this.outroMessage,
  });

  @override
  State<FormSurveyCompletionPage> createState() =>
      _FormSurveyCompletionPageState();
}

class _FormSurveyCompletionPageState extends State<FormSurveyCompletionPage>
    with TickerProviderStateMixin {
  final _appNavigator = getIt.get<AppNavigator>();

  late final AnimationController _animationController = AnimationController(
    vsync: this,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(
          const Duration(seconds: _surveyCompletionPageDurationInSeconds),
          () => _appNavigator.navigateBack(context),
        );
      }
    });

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
            widget.outroMessage ??
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
