import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetLogInStatusUseCase extends SimpleUseCase<Future<bool>> {
  final SecureStorage _secureStorage;

  GetLogInStatusUseCase(this._secureStorage);

  @override
  Future<bool> call() async {
    final String? accesstoken =
        await _secureStorage.readSecureData(accessTokenKey);
    final String? tokenType = await _secureStorage.readSecureData(tokenTypeKey);
    return accesstoken != null && tokenType != null;
  }
}
