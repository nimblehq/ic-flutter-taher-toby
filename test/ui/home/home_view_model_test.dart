import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/survey_model.dart';
import 'package:flutter_survey/ui/home/home_screen.dart';
import 'package:flutter_survey/ui/home/home_state.dart';
import 'package:flutter_survey/ui/home/home_view_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('HomeViewModelTest', () {
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late HomeViewModel homeViewModel;
    late ProviderContainer providerContainer;

    final List<SurveyModel> surveys = <SurveyModel>[
      const SurveyModel(
        id: '1',
        title: 'title',
        description: 'description',
        coverImageUrl: 'coverImageUrl',
      ),
      const SurveyModel(
        id: '2',
        title: 'anotherTitle',
        description: 'anotherDescription',
        coverImageUrl: 'anotherCoverImageUrl',
      ),
    ];

    final UseCaseException exception =
        UseCaseException(const NetworkExceptions.unauthorisedRequest());

    setUp(() {
      mockGetSurveysUseCase = MockGetSurveysUseCase();
      providerContainer = ProviderContainer(
        overrides: [
          homeViewModelProvider.overrideWithValue(
            HomeViewModel(mockGetSurveysUseCase),
          ),
        ],
      );
      homeViewModel = providerContainer.read(homeViewModelProvider.notifier);
    });

    test(
        'When loading surveys successfully, it emits a list of surveys with state LoadSurveysSuccess',
        () {
      when(mockGetSurveysUseCase.call(any)).thenAnswer(
        (_) async => Success(surveys),
      );
      final surveysStream = homeViewModel.surveys;
      final stateStream = homeViewModel.stream;

      homeViewModel.loadSurveys();

      expect(surveysStream, emitsInOrder([surveys]));
      expect(stateStream, emitsInOrder([const HomeState.loadSurveysSuccess()]));
    });

    test(
        'When loading surveys failed, it does not emit a list of surveys with state LoadSurveysError',
        () {
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));
      final errorStream = homeViewModel.error;
      final stateStream = homeViewModel.stream;

      homeViewModel.loadSurveys();

      expect(
          errorStream,
          emitsInOrder(
              [NetworkExceptions.getErrorMessage(exception.actualException)]));
      expect(stateStream, emitsInOrder([const HomeState.loadSurveysError()]));
    });

    tearDown(() {
      addTearDown(providerContainer.dispose);
    });
  });
}
