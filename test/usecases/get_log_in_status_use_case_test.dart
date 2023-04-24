import 'package:flutter_survey/database/secure_storage.dart';
import 'package:flutter_survey/usecases/get_log_in_status_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetLogInStatusUseCaseTest', () {
    late MockSecureStorage mockSecureStorage;
    late GetLogInStatusUseCase getLogInStatusUseCase;

    setUp(() async {
      mockSecureStorage = MockSecureStorage();
      getLogInStatusUseCase = GetLogInStatusUseCase(mockSecureStorage);
    });

    test('When access token and token type stored, it returns a true status',
        () async {
      when(mockSecureStorage.readSecureData(accessTokenKey))
          .thenAnswer((_) async => 'accessToken');
      when(mockSecureStorage.readSecureData(tokenTypeKey))
          .thenAnswer((_) async => 'tokenType');
      final result = await getLogInStatusUseCase.call();

      expect(result, true);
    });

    test(
        'When access token and token type not stored, it returns a false status',
        () async {
      when(mockSecureStorage.readSecureData(any)).thenAnswer((_) async => null);
      final result = await getLogInStatusUseCase.call();

      expect(result, false);
    });
  });
}
