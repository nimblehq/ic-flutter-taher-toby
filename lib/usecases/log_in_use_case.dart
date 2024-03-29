import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/model/auth_token_model.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });
}

@Injectable()
class LogInUseCase extends UseCase<AuthTokenModel, LoginInput> {
  final AuthenticationRepository _authenticationRepository;

  const LogInUseCase(
    this._authenticationRepository,
  );

  @override
  Future<Result<AuthTokenModel>> call(LoginInput input) {
    return _authenticationRepository
        .logIn(
          email: input.email,
          password: input.password,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<AuthTokenModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
