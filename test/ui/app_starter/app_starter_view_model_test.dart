import 'package:flutter_survey/ui/app_starter/app_starter_screen.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_state.dart';
import 'package:flutter_survey/ui/app_starter/app_starter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group(
    'AppStarterViewModelTest',
    () {
      late AppStarterViewModel appStarterViewModel;
      late MockGetLogInStatusUseCase mockGetLogInStatusUseCase;
      late ProviderContainer providerContainer;

      setUp(
        () {
          mockGetLogInStatusUseCase = MockGetLogInStatusUseCase();
          appStarterViewModel = AppStarterViewModel(mockGetLogInStatusUseCase);
          providerContainer = ProviderContainer(
            overrides: [
              appStatretViewModelProvider
                  .overrideWithValue(appStarterViewModel),
            ],
          );
          appStarterViewModel =
              providerContainer.read(appStatretViewModelProvider.notifier);
        },
      );
      test(
        'When starting the app init state will appear',
        () {
          expect(
            providerContainer.read(appStatretViewModelProvider),
            const AppStarterState.init(),
          );
        },
      );
      test(
        'When user previously logged in, it emits home screen state to navigate to the Home screen',
        () async {
          when(mockGetLogInStatusUseCase.call()).thenAnswer((_) async => true);
          final stateStream = appStarterViewModel.stream;
          expect(
            stateStream,
            emitsInOrder(
              [
                const AppStarterState.loading(),
                const AppStarterState.showHomeScreen(),
              ],
            ),
          );
          appStarterViewModel.checkLoginStatus();
        },
      );

      test(
        'When user previously not logged in, it emits login screen state to navigate to the login screen',
        () async {
          when(mockGetLogInStatusUseCase.call()).thenAnswer((_) async => false);
          final stateStream = appStarterViewModel.stream;
          expect(
            stateStream,
            emitsInOrder(
              [
                const AppStarterState.loading(),
                const AppStarterState.showLoginScreen(),
              ],
            ),
          );
          appStarterViewModel.checkLoginStatus();
        },
      );
    },
  );
}
