import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';

@Injectable()
class RefreshTokenUseCase extends UseCase<AuthTokenModel, String> {
  final AuthenticationRepository _authenticationRepository;

  const RefreshTokenUseCase(
    this._authenticationRepository,
  );

  @override
  Future<Result<AuthTokenModel>> call(String input) {
    return _authenticationRepository
        .refreshToken(refreshToken: input)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<AuthTokenModel>)
        .onError<NetworkExceptions>((ex, _) => Failed(UseCaseException(ex)));
  }
}
