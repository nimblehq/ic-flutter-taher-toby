import 'package:flutter_survey/ui/login/login_screen.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/ui/login/login_view_model.dart';
import 'package:flutter_survey/utils/storage/secure_storage.dart';
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
      late ProviderContainer providerContainer;
      final UseCaseException exception =
          UseCaseException(const NetworkExceptions.unauthorisedRequest());
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
          secureStorage = MockSecureStorage();
          loginViewModel = LoginViewModel(mockLogInUseCase, secureStorage);
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
        'When credential provided in correct format login success occurred and token stored',
        () {
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Success(loginModel),
          );
          when(secureStorage.readSecureData(accessTokenKey))
              .thenAnswer((_) async => loginModel.accessToken);

          final loginStream = loginViewModel.isLoginSucceed;
          final stateStream = loginViewModel.stream;
          expect(loginStream, emitsInOrder([true]));
          expect(
            stateStream,
            emitsInOrder([
              const LoginState.loading(),
              const LoginState.loginSuccess(),
            ]),
          );
          loginViewModel.logIn("email@gmail.com", "password1234");
          expect(secureStorage.readSecureData(accessTokenKey),
              completion(equals(loginModel.accessToken)));
        },
      );
      test(
        'When credential provided in wrong format, format error occurred',
        () {
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Failed(exception),
          );
          final loginErrorStream = loginViewModel.loginError;
          final stateStream = loginViewModel.stream;
          expect(
              loginErrorStream,
              emitsInOrder([
                '',
                'Email or password format is not valid. Please try again!'
              ]));
          expect(
            stateStream,
            emitsInOrder([
              const LoginState.loading(),
              const LoginState.loginError(),
            ]),
          );
          loginViewModel.logIn("email", "password");
        },
      );

      test(
        'When credential provided in correct format but wrong value login error occurred',
        () {
          when(mockLogInUseCase.call(any)).thenAnswer(
            (_) async => Failed(exception),
          );
          final loginErrorStream = loginViewModel.loginError;
          final stateStream = loginViewModel.stream;
          final error =
              NetworkExceptions.getErrorMessage(exception.actualException);
          final errorMessage = '$error. Try Again!';
          expect(loginErrorStream, emitsInOrder(['', errorMessage]));
          expect(
            stateStream,
            emitsInOrder([
              const LoginState.loading(),
              const LoginState.loginError(),
            ]),
          );
          loginViewModel.logIn("email@gmail.com", "password12345");
        },
      );
    },
  );
}
