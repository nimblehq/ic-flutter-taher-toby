import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/ui/login/login_view_model.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/model/login_model.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group(
    'LoginViewModelTest',
    () {
      late LoginViewModel loginViewModel;
      late MockSecureStorage secureStorage;
      late MockLogInUseCase mockLogInUseCase;
      late MockAuthTokenStorageUseCase mockAuthTokenStorageUseCase;
      late ProviderContainer providerContainer;
      const loginModel = LoginModel(
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 10,
        refreshToken: "refreshToken",
        createdAt: 1,
      );
      setUp(
        () {
          mockLogInUseCase = MockLogInUseCase();
          mockAuthTokenStorageUseCase = MockAuthTokenStorageUseCase();
          secureStorage = MockSecureStorage();
          loginViewModel = LoginViewModel(
            mockLogInUseCase,
            mockAuthTokenStorageUseCase,
          );
          providerContainer = ProviderContainer(
            overrides: [
              loginViewModelProvider.overrideWithValue(loginViewModel),
            ],
          );
          loginViewModel =
              providerContainer.read(loginViewModelProvider.notifier);
        },
      );
      test(
        'When starting the app init state will appear',
        () {
          expect(
            providerContainer.read(loginViewModelProvider),
            const LoginState.init(),
          );
        },
      );
      test(
        'When credential provided in correct format, login success occurred and token stored',
        () async {
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Success(loginModel),
          );
          when(secureStorage.readSecureData(accessTokenKey))
              .thenAnswer((_) async => loginModel.accessToken);
          final stateStream = loginViewModel.stream;
          expect(
            stateStream,
            emitsInOrder(
              [
                const LoginState.loading(),
                const LoginState.loginSuccess(),
              ],
            ),
          );
          loginViewModel.logIn("email@gmail.com", "password1234");
          expect(
            secureStorage.readSecureData(accessTokenKey),
            completion(
              equals(loginModel.accessToken),
            ),
          );
          await untilCalled(mockAuthTokenStorageUseCase.save(any));
          verify(mockAuthTokenStorageUseCase.save(any)).called(1);
        },
      );

      test(
        'When credential provided in correct format, but wrong value login error occurred',
        () {
          final mockException = MockUseCaseException();
          when(mockException.actualException)
              .thenReturn(const NetworkExceptions.badRequest());

          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Failed(mockException),
          );
          final stateStream = loginViewModel.stream;
          expect(
            stateStream,
            emitsInOrder(
              [
                const LoginState.loading(),
                LoginState.loginError(
                  NetworkExceptions.getErrorMessage(
                    const NetworkExceptions.badRequest(),
                  ),
                ),
              ],
            ),
          );
          loginViewModel.logIn("email@gmail.com", "password12345");
        },
      );
    },
  );
}
