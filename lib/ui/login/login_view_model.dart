import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/usecases/store_auth_token_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LogInUseCase _logInUseCase;
  final StoreAuthTokenUseCase _storeAuthTokenUseCase;

  LoginViewModel(
    this._logInUseCase,
    this._storeAuthTokenUseCase,
  ) : super(const LoginState.init());

  void logIn(String email, String password) async {
    state = const LoginState.loading();
    final LoginInput input = LoginInput(
      email: email,
      password: password,
    );
    final loginResult = await _logInUseCase.call(input);
    if (loginResult is Success<AuthTokenModel>) {
      final AuthTokenModel authTokenModel = loginResult.value;
      final storeTokenResult =
          await _storeAuthTokenUseCase.call(authTokenModel);
      if (storeTokenResult is Success) {
        state = const LoginState.loginSuccess();
      } else {
        state = LoginState.loginError(
            (storeTokenResult as Failed).getErrorMessage());
      }
    } else {
      final String apiError = (loginResult as Failed).getErrorMessage();
      state = LoginState.loginError(apiError);
    }
  }
}
