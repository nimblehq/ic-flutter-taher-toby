import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/usecases/get_cached_surveys_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCachedSurveysUseCaseTest', () {
    late MockSurveyStorage mockSurveyStorage;
    late GetCachedSurveysUseCase getCachedSurveysUseCase;

    setUp(() async {
      mockSurveyStorage = MockSurveyStorage();
      getCachedSurveysUseCase = GetCachedSurveysUseCase(mockSurveyStorage);
    });

    test(
        'When fetching cached surveys, it returns cached surveys correspondingly',
        () async {
      final surveys = <SurveyModel>[];
      when(mockSurveyStorage.surveys).thenAnswer((_) => surveys);

      final result = getCachedSurveysUseCase.call();

      expect(result, surveys);
    });
  });
}
