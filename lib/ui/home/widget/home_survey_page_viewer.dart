import 'package:flutter/material.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page.dart';

class HomeSurveyPageViewer extends StatelessWidget {
  final List<SurveyModel> surveys;
  final ValueNotifier<int> currentPage;

  final _appNavigator = getIt.get<AppNavigator>();
  final _pageController = PageController();

  HomeSurveyPageViewer({
    Key? key,
    required this.surveys,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: surveys.length,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        final survey = surveys[index];
        return HomeSurveyPage(
          survey: survey,
          onNextButtonPressed: () {
            _appNavigator.navigateToFormScreen(
              context: context,
              surveyId: survey.id,
            );
          },
        );
      },
      onPageChanged: (int index) {
        currentPage.value = index;
      },
    );
  }
}
