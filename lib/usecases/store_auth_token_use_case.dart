import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class StoreAuthTokenUseCase extends DataSaverUseCase<LoginModel> {
  final SecureStorage _secureStorage;

  const StoreAuthTokenUseCase(
    this._secureStorage,
  );

  @override
  void save(LoginModel data) async {
    try {
      await _secureStorage.writeSecureData(accessTokenKey, data.accessToken);
      await _secureStorage.writeSecureData(refreshTokenKey, data.refreshToken);
      await _secureStorage.writeSecureData(tokenTypeKey, data.tokenType);
    } catch (exception) {
      throw Failed(UseCaseException(exception));
    }
  }
}
