import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/survey_repository.dart';
import 'package:flutter_survey/api/response/surveys_response.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/file_utils.dart';

void main() {
  group(
    'SurveyRepositoryTest',
    () {
      late MockSurveyService mockSurveyService;
      late MockSurveyStorage mockSurveyStorage;
      late SurveyRepository surveyRepository;

      setUp(
        () {
          mockSurveyService = MockSurveyService();
          mockSurveyStorage = MockSurveyStorage();
          surveyRepository = SurveyRepositoryImpl(
            mockSurveyService,
            mockSurveyStorage,
          );
        },
      );

      test(
        "When getSurveys() success, it returns a list of survey models",
        () async {
          final json =
              await FileUtils.loadFile('test/mock_responses/surveys.json');
          final surveysResponse = SurveysResponse.fromJson(json);

          when(mockSurveyService.getSurveys(any, any))
              .thenAnswer((_) async => surveysResponse);

          final surveysModel =
              await surveyRepository.getSurveys(pageNumber: 1, pageSize: 2);

          expect(surveysModel.length, 2);
          expect(surveysModel[0],
              SurveyModel.fromResponse(surveysResponse.surveys![0]));
          expect(surveysModel[1],
              SurveyModel.fromResponse(surveysResponse.surveys![1]));
          verify(mockSurveyStorage.saveSurveys(surveysModel)).called(1);
        },
      );

      test(
        'When calling getSurveys() failed, it returns an exception error',
        () async {
          when(mockSurveyService.getSurveys(any, any))
              .thenThrow(MockDioError());

          result() => surveyRepository.getSurveys(pageNumber: 1, pageSize: 2);

          expect(result, throwsA(isA<NetworkExceptions>()));
          verifyNever(mockSurveyStorage.saveSurveys(any));
        },
      );
    },
  );
}
