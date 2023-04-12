import 'package:flutter/material.dart';
import 'package:flutter_survey/di/provider/di.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_detail_page.dart';
import 'package:flutter_survey/ui/form/widget/form_survey_question_page.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';

class FormScreen extends StatelessWidget {
  final String surveyId;

  final _pageController = PageController();

  // TODO: Integrate with VM #23
  final _getSurveyDetailsUseCase = getIt.get<GetSurveyDetailsUseCase>();

  FormScreen({
    Key? key,
    required this.surveyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Integrate with VM #23
    _getSurveyDetailsUseCase.call(
      GetSurveyDetailsInput(
        surveyId: surveyId,
      ),
    );
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
