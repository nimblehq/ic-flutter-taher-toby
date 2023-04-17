import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_detail_page.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_question_page.dart';

class FormScreen extends StatelessWidget {
  final _pageController = PageController();

  FormScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          // TODO: Integrate item count from survey details #23
          itemCount: 3,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const FormSurveyDetailPage();
            } else {
              return const FormSurveyQuestionPage();
            }
          },
        ),
      ),
    );
  }
}
