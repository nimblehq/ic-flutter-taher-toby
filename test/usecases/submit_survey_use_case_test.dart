import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/submit_survey_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SubmitSurveyUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late SubmitSurveyUseCase submitSurveyUseCase;

    setUp(() async {
      mockSurveyRepository = MockSurveyRepository();
      submitSurveyUseCase = SubmitSurveyUseCase(mockSurveyRepository);
    });

    test(
        'When submitSurvey has succeeded, it emits a success result with empty value',
        () async {
      final input = SubmitSurveyInput(surveyId: 'surveyId', questions: []);
      when(mockSurveyRepository.submitSurvey(
        surveyId: 'surveyId',
        questions: [],
      )).thenAnswer((_) async => _);
      final result = await submitSurveyUseCase.call(input);

      expect(result, isA<Success>());
      expect((result as Success).value, null);
    });

    test('When submitSurvey has failed, it emits a failed result', () async {
      const exception = NetworkExceptions.badRequest();
      final input = SubmitSurveyInput(surveyId: 'surveyId', questions: []);
      when(mockSurveyRepository.submitSurvey(
        surveyId: 'surveyId',
        questions: [],
      )).thenAnswer((_) async => Future.error(exception));
      final result = await submitSurveyUseCase.call(input);

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
