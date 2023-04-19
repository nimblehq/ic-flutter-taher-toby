import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/usecases/auth_token_storage_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LogInUseCase _loginUseCase;
  final AuthTokenStorageUseCase _authTokenStorageUseCase;

  LoginViewModel(
    this._loginUseCase,
    this._authTokenStorageUseCase,
  ) : super(const LoginState.init());

  void logIn(String email, String password) async {
    state = const LoginState.loading();
    final LoginInput input = LoginInput(
      email: email,
      password: password,
    );
    final result = await _loginUseCase.call(input);
    if (result is Success<LoginModel>) {
      final LoginModel loginData = result.value;
      _authTokenStorageUseCase.save(loginData);
      state = const LoginState.loginSuccess();
    } else {
      final String apiError = (result as Failed).getErrorMessage();
      state = LoginState.loginError(apiError);
    }
  }
}
