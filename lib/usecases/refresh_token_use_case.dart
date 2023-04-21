import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';

@Injectable()
class RefreshTokenUseCase extends UseCase<LoginModel, String> {
  final AuthenticationRepository _authenticationRepository;

  const RefreshTokenUseCase(
    this._authenticationRepository,
  );

  @override
  Future<Result<LoginModel>> call(String input) {
    return _authenticationRepository
        .getAuthToken(refreshToken: input)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<LoginModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
