import 'package:flutter_survey/database/secure_storage.dart';
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
      late MockSecureStorage mockSecureStorage;
      late ProviderContainer providerContainer;

      setUp(
        () {
          mockSecureStorage = MockSecureStorage();
          appStarterViewModel = AppStarterViewModel(mockSecureStorage);
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
          when(mockSecureStorage.readSecureData(accessTokenKey))
              .thenAnswer((_) async => 'accessToken');
          when(mockSecureStorage.readSecureData(tokenTypeKey))
              .thenAnswer((_) async => 'tokenType');
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
          when(mockSecureStorage.readSecureData(any))
              .thenAnswer((_) async => null);
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
