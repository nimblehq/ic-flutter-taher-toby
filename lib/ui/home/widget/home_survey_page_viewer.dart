import 'package:flutter/material.dart';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/ui/widget/next_button.dart';

// TODO: Integrate surveys https://github.com/nimblehq/ic-flutter-taher-toby/issues/13
class HomeSurveyPageViewer extends StatelessWidget {
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
            _appNavigator.navigateToSecondScreen(context);
          },
        );
      },
    );
  }
}
