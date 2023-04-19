import 'package:flutter_survey/database/shared_preferences.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/database/secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthTokenStorageUseCase extends DataSaverUseCase<LoginModel> {
  final SecureStorage _secureStorage;
  final SharedPreferencesStorage _sharedPreferences;

  const AuthTokenStorageUseCase(
    this._secureStorage,
    this._sharedPreferences,
  );

  @override
  void save(LoginModel data) async {
    await _secureStorage.writeSecureData(accessTokenKey, data.accessToken);
    await _secureStorage.writeSecureData(refreshTokenKey, data.refreshToken);
    await _secureStorage.writeSecureData(tokenTypeKey, data.tokenType);
    _sharedPreferences.saveLoginStatus(true);
  }
}
