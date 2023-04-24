import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/is_logged_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('IsLoggedInnUseCaseTest', () {
    late MockSecureStorage mockSecureStorage;
    late IsLoggedInUseCase isLoggedInUseCase;

    setUp(() async {
      mockSecureStorage = MockSecureStorage();
      isLoggedInUseCase = IsLoggedInUseCase(mockSecureStorage);
    });

    test('When access token and token type stored, it returns a true status',
        () async {
      when(mockSecureStorage.readSecureData(accessTokenKey))
          .thenAnswer((_) async => 'accessToken');
      when(mockSecureStorage.readSecureData(tokenTypeKey))
          .thenAnswer((_) async => 'tokenType');
      final result = await isLoggedInUseCase.call();

      expect(result, true);
    });

    test(
        'When access token and token type not stored, it returns a false status',
        () async {
      when(mockSecureStorage.readSecureData(any)).thenAnswer((_) async => null);
      final result = await isLoggedInUseCase.call();

      expect(result, false);
    });
  });
}
