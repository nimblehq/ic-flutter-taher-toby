import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/api/repository/login_repository.dart';
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
class LoginUseCase extends UseCase<LoginModel, LoginInput> {
  final LoginRepository _loginRepository;

  const LoginUseCase(this._loginRepository);

  @override
  Future<Result<LoginModel>> call(LoginInput input) {
    return _loginRepository
        .doLogin(input: input)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<LoginModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
