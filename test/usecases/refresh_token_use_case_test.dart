import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/refresh_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockAuthenticationRepository mockAuthenticationRepository;
    late RefreshTokenUseCase refreshTokenUseCase;

    setUp(() async {
      mockAuthenticationRepository = MockAuthenticationRepository();
      refreshTokenUseCase = RefreshTokenUseCase(mockAuthenticationRepository);
    });

    test('When call execution has succeeded, it returns a Success result',
        () async {
      const loginModel = LoginModel(
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 10,
        refreshToken: "refreshToken",
        createdAt: 1,
      );
      when(
        mockAuthenticationRepository.getAuthToken(refreshToken: 'refreshToken'),
      ).thenAnswer((_) async => loginModel);

      final result = await refreshTokenUseCase.call('refreshToken');

      expect(result, isA<Success>());
      expect((result as Success).value, loginModel);
    });

    test('When call execution has failed, it returns a Failed result',
        () async {
      const exception = NetworkExceptions.badRequest();
      when(
        mockAuthenticationRepository.getAuthToken(refreshToken: 'refreshToken')
      ).thenAnswer((_) => Future.error(exception));

      final result = await refreshTokenUseCase.call('refreshToken');

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
