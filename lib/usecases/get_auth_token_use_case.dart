import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/model/auth_token_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetAuthTokenUseCase extends SimpleUseCase<Future<AuthTokenModel>> {
  final SecureStorage _secureStorage;

  GetAuthTokenUseCase(this._secureStorage);

  @override
  Future<AuthTokenModel> call() async {
    final String accesstoken =
        await _secureStorage.readSecureData(accessTokenKey) ?? '';
    final String refreshToken =
        await _secureStorage.readSecureData(refreshTokenKey) ?? '';
    final String tokenType =
        await _secureStorage.readSecureData(tokenTypeKey) ?? '';
    final AuthTokenModel authTokenModel = AuthTokenModel(
      accessToken: accesstoken,
      tokenType: tokenType,
      expiresIn: 0,
      refreshToken: refreshToken,
      createdAt: 0,
    );
    return authTokenModel;
  }
}
