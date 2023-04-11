import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_survey/api/repository/login_repository.dart';
import 'package:flutter_survey/api/response/login_response.dart';
import 'package:flutter_survey/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_survey/api/exception/network_exceptions.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/file_utils.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'REST_API_CLIENT_ID': 'REST_API_CLIENT_ID',
    'REST_API_CLIENT_SECRET': 'REST_API_CLIENT_SECRET',
  });
  group('LoginRepositoryTest', () {
    late MockLoginService mockLoginService;
    late LoginRepository loginRepository;
    final LoginInput loginInput = LoginInput(
      email: "email",
      password: "password",
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

        final loginModel = await loginRepository.doLogin(input: loginInput);

        expect(loginModel.accessToken,
            "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c");
      },
    );

    test(
      'When doLogin() failed, it returns an exception error',
      () async {
        when(mockLoginService.doLogin(any)).thenThrow(MockDioError());

        result() => loginRepository.doLogin(input: loginInput);

        expect(result, throwsA(isA<NetworkExceptions>()));
      },
    );
  });
}
