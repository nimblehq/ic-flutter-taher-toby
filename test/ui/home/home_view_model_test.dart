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
    late MockGetCachedSurveysUseCase mockGetCachedSurveysUseCase;
    late MockGetSurveysUseCase mockGetSurveysUseCase;
    late HomeViewModel homeViewModel;
    late ProviderContainer providerContainer;

    final List<SurveyModel> cachedSurveys = <SurveyModel>[
      const SurveyModel(
        id: 'id',
        title: 'title',
        description: 'description',
        coverImageUrl: 'coverImageUrl',
      ),
      const SurveyModel(
        id: 'id2',
        title: 'title2',
        description: 'description2',
        coverImageUrl: 'coverImageUrl2',
      ),
    ];

    final List<SurveyModel> surveys = <SurveyModel>[
      const SurveyModel(
        id: 'id3',
        title: 'title3',
        description: 'description3',
        coverImageUrl: 'coverImageUrl3',
      ),
      const SurveyModel(
        id: 'id4',
        title: 'title4',
        description: 'description4',
        coverImageUrl: 'coverImageUrl4',
      ),
    ];

    final UseCaseException exception =
        UseCaseException(const NetworkExceptions.unauthorisedRequest());

    setUp(() {
      mockGetCachedSurveysUseCase = MockGetCachedSurveysUseCase();
      mockGetSurveysUseCase = MockGetSurveysUseCase();
      providerContainer = ProviderContainer(
        overrides: [
          homeViewModelProvider.overrideWithValue(
            HomeViewModel(
              mockGetCachedSurveysUseCase,
              mockGetSurveysUseCase,
            ),
          ),
        ],
      );
      homeViewModel = providerContainer.read(homeViewModelProvider.notifier);
    });

    test(
        'When loading cached surveys successfully, it emits a list of surveys with state LoadCachedSurveysSuccess',
        () {
      when(mockGetCachedSurveysUseCase.call()).thenAnswer((_) => cachedSurveys);
      final surveysStream = homeViewModel.surveys;
      final stateStream = homeViewModel.stream;

      expect(surveysStream, emitsInOrder([cachedSurveys]));
      expect(stateStream,
          emitsInOrder([const HomeState.loadCachedSurveysSuccess()]));

      homeViewModel.loadCachedSurveys();
    });

    test(
        'When loading surveys successfully, it emits a list of surveys with state LoadSurveysSuccess',
        () {
      when(mockGetSurveysUseCase.call(any)).thenAnswer(
        (_) async => Success(surveys),
      );
      final surveysStream = homeViewModel.surveys;
      final stateStream = homeViewModel.stream;

      expect(surveysStream, emitsInOrder([surveys]));
      expect(
        stateStream,
        emitsInOrder([
          const HomeState.loading(),
          const HomeState.loadSurveysSuccess(),
        ]),
      );

      homeViewModel.loadSurveys();
    });

    test(
        'When loading surveys failed, it does not emit a list of surveys with state LoadSurveysError',
        () {
      when(mockGetSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(exception));
      final errorStream = homeViewModel.error;
      final stateStream = homeViewModel.stream;

      expect(
          errorStream,
          emitsInOrder(
              [NetworkExceptions.getErrorMessage(exception.actualException)]));
      expect(
        stateStream,
        emitsInOrder([
          const HomeState.loading(),
          const HomeState.loadSurveysError(),
        ]),
      );

      homeViewModel.loadSurveys();
    });

    tearDown(() {
      providerContainer.dispose;
    });
  });
}
