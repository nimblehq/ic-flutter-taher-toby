import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/utils/storage/secure_storage.dart';
import 'package:rxdart/subjects.dart';
import 'package:email_validator/email_validator.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LogInUseCase _loginUseCase;
  final SecureStorage _secureStorage;

  LoginViewModel(
    this._loginUseCase,
    this._secureStorage,
  ) : super(const LoginState.init());

  final PublishSubject<bool?> _isLoginSucceed = PublishSubject();
  Stream<bool?> get isLoginSucceed => _isLoginSucceed.stream;

  final PublishSubject<String?> _loginError = PublishSubject();
  Stream<String?> get loginError => _loginError.stream;

  void logIn(String email, String password) async {
    _loginError.add('');
    state = const LoginState.loading();
    if (_isCredentialsValid(email, password)) {
      final LoginInput input = LoginInput(
        email: email,
        password: password,
      );
      final result = await _loginUseCase.call(input);
      if (result is Success<LoginModel>) {
        final LoginModel loginData = result.value;
        _isLoginSucceed.add(true);
        _storeLoginData(loginData);
        state = const LoginState.loginSuccess();
      } else {
        final apiError = (result as Failed).getErrorMessage();
        final errorText = '$apiError. Try Again!';
        _loginError.add(errorText);
        state = const LoginState.loginError();
      }
    } else {
      _loginError
          .add("Email or password format is not valid. Please try again!");
      state = const LoginState.loginError();
    }
  }

  void _storeLoginData(LoginModel data) async {
    await _secureStorage.writeSecureData(accessTokenKey, data.accessToken);
    await _secureStorage.writeSecureData(refreshTokenKey, data.refreshToken);
  }

  bool _isCredentialsValid(String email, String password) {
    return EmailValidator.validate(email) &&
        password.isNotEmpty &&
        password.length >= 8;
  }
}
