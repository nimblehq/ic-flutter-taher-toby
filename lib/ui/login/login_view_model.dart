import 'package:flutter_survey/model/login_model.dart';
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
    final result = await _logInUseCase.call(input);
    if (result is Success<LoginModel>) {
      final LoginModel loginData = result.value;
      final dataSaverResult = await _storeAuthTokenUseCase.call(loginData);
      if (dataSaverResult is Success) {
        state = const LoginState.loginSuccess();
      } else {
        state = LoginState.loginError(
            (dataSaverResult as Failed).getErrorMessage());
      }
    } else {
      final String apiError = (result as Failed).getNetworkErrorMessage();
      state = LoginState.loginError(apiError);
    }
  }
}
