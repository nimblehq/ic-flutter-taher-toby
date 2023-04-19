import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/usecases/log_in_storage_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:email_validator/email_validator.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LogInUseCase _loginUseCase;
  final LogInStorageUseCase _logInStorageUseCase;

  LoginViewModel(
    this._loginUseCase,
    this._logInStorageUseCase,
  ) : super(const LoginState.init());

  void logIn(String email, String password, BuildContext context) async {
    state = const LoginState.loading();
    if (_isCredentialsValid(email, password)) {
      final LoginInput input = LoginInput(
        email: email,
        password: password,
      );
      final result = await _loginUseCase.call(input);
      if (result is Success<LoginModel>) {
        final LoginModel loginData = result.value;
        _logInStorageUseCase.save(loginData);
        state = const LoginState.loginSuccess();
      } else {
        final String apiError = (result as Failed).getErrorMessage();
        state = LoginState.loginError(apiError);
      }
    } else {
      state =
          LoginState.loginError(AppLocalizations.of(context)?.auth_error ?? '');
    }
  }

  bool _isCredentialsValid(String email, String password) {
    return EmailValidator.validate(email) &&
        password.isNotEmpty &&
        password.length >= 8;
  }
}
