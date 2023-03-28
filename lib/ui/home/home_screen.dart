import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/home/widget/home_header.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page_indicator.dart';
import 'package:flutter_survey/ui/home/widget/home_survey_page_viewer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeSurveyPageViewer(),
        const HomeHeader(),
        const HomeSurveyPageIndicator(),
      ],
    );
  }
}
