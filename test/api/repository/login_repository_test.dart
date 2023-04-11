import 'package:flutter_survey/api/repository/login_repository.dart';
import 'package:flutter_survey/api/request/login_request.dart';
import 'package:flutter_survey/api/response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/file_utils.dart';

void main() {
  group('LoginRepositoryTest', () {
    late MockLoginService mockLoginService;
    late LoginRepository loginRepository;
    final LoginRequest loginRequest = LoginRequest(
      grantType: "grantType",
      email: "email",
      password: "password",
      clientId: "clientId",
      clientSecret: "clientSecret",
    );

    setUp(
      () {
        mockLoginService = MockLoginService();
        loginRepository = LoginRepositoryImpl(mockLoginService);
      },
    );

    test(
      "When doLogin() success, it returns access token",
      () async {
        final json =
            await FileUtils.loadFile('test/mock_responses/login_data.json');
        final loginResponse = LoginResponse.fromJson(json);

        when(mockLoginService.doLogin(any))
            .thenAnswer((_) async => loginResponse);

        final loginModel = await loginRepository.doLogin(
          request: loginRequest,
        );

        expect(loginModel.accessToken,
            "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c");
      },
    );

    test(
      'When doLogin() failed, it returns an exception error',
      () async {
        when(mockLoginService.doLogin(any)).thenThrow(MockDioError());

        result() => loginRepository.doLogin(
              request: loginRequest,
            );

        expect(result, throwsA(isA<NetworkExceptions>()));
      },
    );
  });
}
