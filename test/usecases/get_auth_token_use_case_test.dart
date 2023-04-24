import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/get_auth_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetLogInStatusUseCaseTest', () {
    late MockSecureStorage mockSecureStorage;
    late GetAuthTokenUseCase getAuthTokenUseCase;

    setUp(() async {
      mockSecureStorage = MockSecureStorage();
      getAuthTokenUseCase = GetAuthTokenUseCase(mockSecureStorage);
    });

    test('When fetching auth token data it returns accordingly', () async {
      when(mockSecureStorage.readSecureData(accessTokenKey))
          .thenAnswer((_) async => 'accessToken');
      when(mockSecureStorage.readSecureData(tokenTypeKey))
          .thenAnswer((_) async => 'tokenType');
      when(mockSecureStorage.readSecureData(refreshTokenKey))
          .thenAnswer((_) async => 'refreshToken');
      final result = await getAuthTokenUseCase.call();

      expect(result.accessToken, 'accessToken');
      expect(result.tokenType, 'tokenType');
      expect(result.refreshToken, 'refreshToken');
    });
  });
}
