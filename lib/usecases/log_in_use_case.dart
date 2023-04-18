import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/model/login_model.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });
}

@Injectable()
class LogInUseCase extends UseCase<LoginModel, LoginInput> {
  final AuthenticationRepository _authenticationRepository;
  final SecureStorage _secureStorage;

  const LogInUseCase(
    this._authenticationRepository,
    this._secureStorage,
  );

  @override
  Future<Result<LoginModel>> call(LoginInput input) {
    return _authenticationRepository
        .logIn(
          email: input.email,
          password: input.password,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<LoginModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }

  void storeLoginData(LoginModel data) async {
    await _secureStorage.writeSecureData(accessTokenKey, data.accessToken);
    await _secureStorage.writeSecureData(refreshTokenKey, data.refreshToken);
    await _secureStorage.writeSecureData(tokenTypeKey, data.tokenType);
  }
}
