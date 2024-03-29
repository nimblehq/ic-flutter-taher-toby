import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class StoreAuthTokenUseCase extends UseCase<void, AuthTokenModel> {
  final SecureStorage _secureStorage;

  const StoreAuthTokenUseCase(this._secureStorage);

  @override
  Future<Result<void>> call(AuthTokenModel input) async {
    try {
      await _secureStorage.writeSecureData(accessTokenKey, input.accessToken);
      await _secureStorage.writeSecureData(refreshTokenKey, input.refreshToken);
      await _secureStorage.writeSecureData(tokenTypeKey, input.tokenType);
      return Success(null);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
