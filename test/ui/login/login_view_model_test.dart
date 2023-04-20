import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/ui/login/login_view_model.dart';
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
      late MockLogInUseCase mockLogInUseCase;
      late MockStoreAuthTokenUseCase mockStoreAuthTokenUseCase;
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
          mockStoreAuthTokenUseCase = MockStoreAuthTokenUseCase();
          loginViewModel = LoginViewModel(
            mockLogInUseCase,
            mockStoreAuthTokenUseCase,
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
        'When logging in & storing the token successfully, it emits loginSuccess state to navigate to the Home screen',
        () async {
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Success(loginModel),
          );
          when(mockStoreAuthTokenUseCase.call(any)).thenAnswer(
            (_) async => Success(null),
          );
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
        },
      );

      test(
        'When logging in successfull but storing data is failed it emits loginError state',
        () async {
          final mockException = MockUseCaseException();
          when(mockException.actualException)
              .thenReturn(const NetworkExceptions.unableToProcess());
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Success(loginModel),
          );
          when(mockStoreAuthTokenUseCase.call(any)).thenAnswer(
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
                    const NetworkExceptions.unableToProcess(),
                  ),
                ),
              ],
            ),
          );
          loginViewModel.logIn("email@gmail.com", "password1234");
        },
      );
      test(
        'When logging in failed it emits liginError state',
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
