import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/store_auth_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('StoreAuthTokenUseCaseTest', () {
    late StoreAuthTokenUseCase storeAuthTokenUseCase;
    late MockSecureStorage mockSecureStorage;

    setUp(() async {
      mockSecureStorage = MockSecureStorage();
      storeAuthTokenUseCase = StoreAuthTokenUseCase(mockSecureStorage);
    });

    test(
        'When save execution has succeeded, data saved in secure storage successfully',
        () async {
      const loginModel = LoginModel(
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 10,
        refreshToken: "refreshToken",
        createdAt: 1,
      );
      storeAuthTokenUseCase.call(loginModel);
      await untilCalled(
          mockSecureStorage.writeSecureData(accessTokenKey, "accessToken"));
      await untilCalled(
          mockSecureStorage.writeSecureData(refreshTokenKey, "refreshToken"));
      await untilCalled(
          mockSecureStorage.writeSecureData(tokenTypeKey, "tokenType"));
      verify(mockSecureStorage.writeSecureData(accessTokenKey, "accessToken"))
          .called(1);
      verify(mockSecureStorage.writeSecureData(refreshTokenKey, "refreshToken"))
          .called(1);
      verify(mockSecureStorage.writeSecureData(tokenTypeKey, "tokenType"))
          .called(1);
    });
  });
}
