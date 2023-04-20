import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/ui/form/form_state.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';
import 'package:rxdart/subjects.dart';

class FormViewModel extends StateNotifier<FormState> {
  final GetSurveyDetailsUseCase _getSurveyDetailsUseCase;

  FormViewModel(this._getSurveyDetailsUseCase) : super(const FormState.init());

  final BehaviorSubject<SurveyDetailsModel> _surveyDetails = BehaviorSubject();

  Stream<SurveyDetailsModel> get surveyDetails => _surveyDetails.stream;

  final PublishSubject<String?> _error = PublishSubject();

  Stream<String?> get error => _error.stream;

  void loadSurveyDetails(String surveyId) async {
    state = const FormState.loading();
    final result = await _getSurveyDetailsUseCase.call(
      GetSurveyDetailsInput(
        surveyId: surveyId,
      ),
    );
    if (result is Success<SurveyDetailsModel>) {
      _surveyDetails.add(result.value);
      state = const FormState.loadSurveyDetailsSuccess();
    } else {
      _error.add((result as Failed).getNetworkErrorMessage());
      state = const FormState.loadSurveyDetailsError();
    }
  }
}
