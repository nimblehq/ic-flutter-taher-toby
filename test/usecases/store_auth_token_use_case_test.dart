import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
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
      storeAuthTokenUseCase = StoreAuthTokenUseCase(
        mockSecureStorage,
      );
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
      final result = await storeAuthTokenUseCase.call(loginModel);
      expect(result, isA<Success>());
      expect((result as Success).value, null);
    });

    test('When save execution has failed, it returns a failed result',
        () async {
      final exception = Exception("storage exception");
      when(mockSecureStorage.writeSecureData(any, any))
          .thenAnswer((_) => Future.error(exception));
      const loginModel = LoginModel(
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 10,
        refreshToken: "refreshToken",
        createdAt: 1,
      );
      final result = await storeAuthTokenUseCase.call(loginModel);
      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
