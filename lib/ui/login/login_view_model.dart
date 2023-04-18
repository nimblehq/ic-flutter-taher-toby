import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:email_validator/email_validator.dart';

const String formatErrorText =
    'Email or password format is not valid. Please try again!';

class LoginViewModel extends StateNotifier<LoginState> {
  final LogInUseCase _loginUseCase;
  final SecureStorage _secureStorage;

  LoginViewModel(
    this._loginUseCase,
    this._secureStorage,
  ) : super(const LoginState.init());

  void logIn(String email, String password) async {
    state = const LoginState.loading();
    if (_isCredentialsValid(email, password)) {
      final LoginInput input = LoginInput(
        email: email,
        password: password,
      );
      final result = await _loginUseCase.call(input);
      if (result is Success<LoginModel>) {
        final LoginModel loginData = result.value;
        _storeLoginData(loginData);
        state = const LoginState.loginSuccess();
      } else {
        final String apiError = (result as Failed).getErrorMessage();
        state = LoginState.loginError(apiError);
      }
    } else {
      state = const LoginState.loginError(formatErrorText);
    }
  }

  void _storeLoginData(LoginModel data) async {
    await _secureStorage.writeSecureData(accessTokenKey, data.accessToken);
    await _secureStorage.writeSecureData(refreshTokenKey, data.refreshToken);
    await _secureStorage.writeSecureData(tokenTypeKey, data.tokenType);
  }

  bool _isCredentialsValid(String email, String password) {
    return EmailValidator.validate(email) &&
        password.isNotEmpty &&
        password.length >= 8;
  }
}
