import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:flutter_survey/model/login_model.dart';
import 'package:flutter_survey/usecases/base/base_use_case.dart';
import 'package:flutter_survey/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthenticationRepository mockAuthenticationRepository;
    late LoginUseCase loginUseCase;
    final LoginInput loginInput = LoginInput(
      email: "email",
      password: "password",
    );

    setUp(() async {
      mockAuthenticationRepository = MockAuthenticationRepository();
      loginUseCase = LoginUseCase(mockAuthenticationRepository);
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
        mockAuthenticationRepository.login(
          email: "email",
          password: "password",
        ),
      ).thenAnswer((_) async => loginModel);

      final result = await loginUseCase.call(loginInput);

      expect(result, isA<Success>());
      expect((result as Success).value, loginModel);
    });

    test('When call execution has failed, it returns a Failed result',
        () async {
      const exception = NetworkExceptions.badRequest();
      when(
        mockAuthenticationRepository.login(
          email: "email",
          password: "password",
        ),
      ).thenAnswer((_) => Future.error(exception));

      final result = await loginUseCase.call(loginInput);

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException, exception);
    });
  });
}
