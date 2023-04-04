import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_surveys_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveysUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetSurveysUseCase getSurveysUseCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      getSurveysUseCase = GetSurveysUseCase(mockSurveyRepository);
    });

    test('When execution has succeeded, it returns a Success result', () async {
      const surveysModels = [
        SurveyModel(id: '1', title: '2', description: '3', coverImageUrl: '4'),
        SurveyModel(id: '5', title: '6', description: '7', coverImageUrl: '8'),
      ];
      when(mockSurveyRepository.getSurveys(pageNumber: 1, pageSize: 2))
          .thenAnswer((_) async => surveysModels);

      final result = await getSurveysUseCase
          .call(GetSurveysInput(pageNumber: 1, pageSize: 2));

      expect(result, isA<Success>());
      expect((result as Success).value, surveysModels);
    });

    test('When execution has failed, it returns a Failed result', () async {
      const exception = NetworkExceptions.badRequest();
      when(mockSurveyRepository.getSurveys(pageNumber: 1, pageSize: 2))
          .thenAnswer((_) => Future.error(exception));

      final result = await getSurveysUseCase
          .call(GetSurveysInput(pageNumber: 1, pageSize: 2));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
