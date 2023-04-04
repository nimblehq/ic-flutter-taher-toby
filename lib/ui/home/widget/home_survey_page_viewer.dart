import 'package:flutter/material.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';

const _pageNumber = 1;
const _pageSize = 5;

class HomeSurveyPageViewer extends StatelessWidget {
  // TODO: Integrate use-case with VM https://github.com/nimblehq/ic-flutter-taher-toby/issues/13
  final _getSurveyUseCase = getIt.get<GetSurveysUseCase>();
  final _appNavigator = getIt.get<AppNavigator>();
  final _pageController = PageController();

  HomeSurveyPageViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      controller: _pageController,
      itemBuilder: (BuildContext context, int index) {
        return HomeSurveyPage(
          onNextButtonPressed: () {
            _getSurveyUseCase.call(
                GetSurveysInput(pageNumber: _pageNumber, pageSize: _pageSize));
            _appNavigator.navigateToSecondScreen(context);
          },
        );
      },
    );
  }
}
