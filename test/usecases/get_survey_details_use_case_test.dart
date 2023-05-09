import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/model/answer_model.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/get_survey_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveyDetailsUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetSurveyDetailsUseCase getSurveyDetailsUseCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      getSurveyDetailsUseCase = GetSurveyDetailsUseCase(mockSurveyRepository);
    });

    test('When execution has succeeded, it returns a Success result', () async {
      const surveyDetailsModel = SurveyDetailsModel(
        id: '1',
        title: '2',
        description: '3',
        coverImageUrl: '4',
        questions: [
          QuestionModel(
            id: '5',
            text: '6',
            displayType: DisplayType.smiley,
            answers: [
              AnswerModel(
                id: '7',
                text: '8',
              )
            ],
          ),
        ],
        intro: '',
        outro: '',
      );
      when(mockSurveyRepository.getSurveyDetails(surveyId: "surveyId"))
          .thenAnswer((_) async => surveyDetailsModel);

      final result = await getSurveyDetailsUseCase.call(
        GetSurveyDetailsInput(surveyId: "surveyId"),
      );

      expect(result, isA<Success>());
      expect((result as Success).value, surveyDetailsModel);
    });

    test('When execution has failed, it returns a Failed result', () async {
      const exception = NetworkExceptions.badRequest();
      when(mockSurveyRepository.getSurveyDetails(surveyId: "surveyId"))
          .thenAnswer((_) => Future.error(exception));

      final result = await getSurveyDetailsUseCase.call(
        GetSurveyDetailsInput(surveyId: "surveyId"),
      );

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
