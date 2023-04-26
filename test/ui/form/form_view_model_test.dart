import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/response/question_response.dart';
import 'package:flutter_survey/model/answer_model.dart';
import 'package:flutter_survey/model/question_model.dart';
import 'package:flutter_survey/model/survey_details_model.dart';
import 'package:flutter_survey/ui/form/form_screen.dart';
import 'package:flutter_survey/ui/form/form_state.dart';
import 'package:flutter_survey/ui/form/form_view_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('FormViewModelTest', () {
    late MockGetSurveyDetailsUseCase mockGetSurveyDetailsUseCase;
    late FormViewModel formViewModel;
    late ProviderContainer providerContainer;

    const SurveyDetailsModel surveyDetailsModel = SurveyDetailsModel(
      id: 'id',
      title: 'title',
      description: 'description',
      coverImageUrl: 'coverImageUrl',
      questions: [
        QuestionModel(
          id: 'id2',
          text: 'text2',
          displayType: DisplayType.smiley,
          answers: [
            AnswerModel(
              id: 'id3',
              text: 'id4',
            )
          ],
        ),
      ],
    );

    final UseCaseException exception =
        UseCaseException(const NetworkExceptions.unauthorisedRequest());

    setUp(() {
      mockGetSurveyDetailsUseCase = MockGetSurveyDetailsUseCase();
      providerContainer = ProviderContainer(
        overrides: [
          formViewModelProvider.overrideWithValue(
            FormViewModel(
              mockGetSurveyDetailsUseCase,
            ),
          ),
        ],
      );
      formViewModel = providerContainer.read(formViewModelProvider.notifier);
    });

    test('When initializing, it initializes with state Init', () {
      expect(
        providerContainer.read(formViewModelProvider),
        const FormState.init(),
      );
    });

    test(
        'When loading survey details successfully, it emits an object with state LoadSurveyDetailsSuccess',
        () {
      when(mockGetSurveyDetailsUseCase.call(any)).thenAnswer(
        (_) async => Success(surveyDetailsModel),
      );
      final surveyDetailsStream = formViewModel.surveyDetails;
      final stateStream = formViewModel.stream;

      expect(surveyDetailsStream, emitsInOrder([surveyDetailsModel]));
      expect(
        stateStream,
        emitsInOrder([
          const FormState.loading(),
          const FormState.loadSurveyDetailsSuccess(),
        ]),
      );

      formViewModel.loadSurveyDetails("surveyId");
    });

    test(
        'When loading survey details failed, it does not emit an object with state LoadSurveyDetailsError',
        () {
      when(mockGetSurveyDetailsUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));
      final errorStream = formViewModel.error;
      final stateStream = formViewModel.stream;

      expect(
          errorStream,
          emitsInOrder(
              [NetworkExceptions.getErrorMessage(exception.actualException)]));
      expect(
        stateStream,
        emitsInOrder([
          const FormState.loading(),
          const FormState.loadSurveyDetailsError(),
        ]),
      );

      formViewModel.loadSurveyDetails("surveyId");
    });

    tearDown(() {
      providerContainer.dispose;
    });
  });
}
