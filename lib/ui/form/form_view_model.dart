import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/submit_survey_question_model.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/ui/form/form_state.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';
import 'package:flutter_survey/usecases/submit_survey_use_case.dart';
import 'package:rxdart/subjects.dart';
import 'package:collection/collection.dart';

class FormViewModel extends StateNotifier<FormState> {
  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;
  String? _outroMessage;

  FormViewModel(
    this._getSurveyDetailsUseCase,
    this._submitSurveyUseCase,
  ) : super(const FormState.init());

  final BehaviorSubject<SurveyDetailsModel> _surveyDetails = BehaviorSubject();

  Stream<SurveyDetailsModel> get surveyDetails => _surveyDetails.stream;

  final PublishSubject<String?> _error = PublishSubject();

  Stream<String?> get error => _error.stream;

  final List<SubmitSurveyQuestionModel> submitSurveyQuestions = [];

  void loadSurveyDetails(String surveyId) async {
    state = const FormState.loading();
    final result = await _getSurveyDetailsUseCase.call(
      GetSurveyDetailsInput(
        surveyId: surveyId,
      ),
    );
    if (result is Success<SurveyDetailsModel>) {
      _surveyDetails.add(result.value);
      _outroMessage = result.value.outro;
      state = const FormState.loadSurveyDetailsSuccess();
    } else {
      _error.add((result as Failed).getErrorMessage());
      state = const FormState.loadSurveyDetailsError();
    }
  }

  void saveIndexedAnswer(
    String questionId,
    List<SubmitSurveyAnswerModel> answers,
  ) {
    final question = submitSurveyQuestions
        .firstWhereOrNull((question) => question.id == questionId);

    if (question == null) {
      submitSurveyQuestions.add(SubmitSurveyQuestionModel(
        id: questionId,
        answers: answers,
      ));
    } else {
      question.answers.clear();
      question.answers.addAll(answers);
    }
  }

  void submitAnswer(String surveyId) async {
    state = const FormState.loading();
    final result = await _submitSurveyUseCase.call(
      SubmitSurveyInput(
        surveyId: surveyId,
        questions: submitSurveyQuestions,
      ),
    );
    if (result is Success<void>) {
      state = FormState.surveySubmissionSuccess(_outroMessage ?? '');
    } else {
      _error.add((result as Failed).getErrorMessage());
      state = const FormState.loadSurveyDetailsError();
    }
  }
}
