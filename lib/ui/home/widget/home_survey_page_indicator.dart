import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

const _opacityUnselectedColor = 0.2;

class HomeSurveyPageIndicator extends StatelessWidget {
  final int surveysLength;
  final ValueNotifier<int> currentPage;

  const HomeSurveyPageIndicator({
    Key? key,
    required this.surveysLength,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (BuildContext context, int value, Widget? child) {
        return PageViewDotIndicator(
          currentItem: currentPage.value,
          count: surveysLength,
          selectedColor: Colors.white,
          unselectedColor: Colors.white.withOpacity(_opacityUnselectedColor),
          size: const Size(
            AppDimensions.homeSurveyPageIndicatorSize,
            AppDimensions.homeSurveyPageIndicatorSize,
          ),
          unselectedSize: const Size(
            AppDimensions.homeSurveyPageIndicatorSize,
            AppDimensions.homeSurveyPageIndicatorSize,
          ),
          alignment: Alignment.bottomLeft,
        );
      },
    );
  }
}
