import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/ui/home/home_state.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:rxdart/subjects.dart';

const _surveysPageNumber = 1;
const _surveysPageSize = 5;

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init());

  final BehaviorSubject<List<SurveyModel>> _surveys = BehaviorSubject();

  Stream<List<SurveyModel>> get surveys => _surveys.stream;

  final PublishSubject<String?> _error = PublishSubject();

  Stream<String?> get error => _error.stream;

  void loadSurveys() async {
    final result = await _getSurveysUseCase.call(GetSurveysInput(
      pageNumber: _surveysPageNumber,
      pageSize: _surveysPageSize,
    ));
    if (result is Success<List<SurveyModel>>) {
      final newSurveys = result.value;
      _surveys.add(newSurveys);
      state = const HomeState.loadSurveysSuccess();
    } else {
      _error.add((result as Failed).getErrorMessage());
      state = const HomeState.loadSurveysError();
    }
  }
}
