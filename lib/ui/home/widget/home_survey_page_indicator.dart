import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

const _opacityUnselectedColor = 0.2;

// TODO: Integrate surveys https://github.com/nimblehq/ic-flutter-taher-toby/issues/13
class HomeSurveyPageIndicator extends StatelessWidget {
  const HomeSurveyPageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox.shrink()),
        PageViewDotIndicator(
          currentItem: 1,
          count: 3,
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
        ),
        const SizedBox(height: AppDimensions.spacing200),
      ],
    );
  }
}
