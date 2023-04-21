import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_survey/api/repository/authentication_repository.dart';
import 'package:flutter_survey/api/response/login_response.dart';
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
  group('authenticationRepositoryTest', () {
    late MockAuthenticationService mockAuthenticationService;
    late AuthenticationRepository authenticationRepository;

    setUp(
      () {
        mockAuthenticationService = MockAuthenticationService();
        authenticationRepository =
            AuthenticationRepositoryImpl(mockAuthenticationService);
      },
    );

    test(
      "When login() success, it returns access token",
      () async {
        final json =
            await FileUtils.loadFile('test/mock_responses/login_data.json');
        final loginResponse = LoginResponse.fromJson(json);

        when(mockAuthenticationService.logIn(any))
            .thenAnswer((_) async => loginResponse);

        final loginModel = await authenticationRepository.logIn(
          email: "email",
          password: "password",
        );

        expect(loginModel.accessToken,
            "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c");
      },
    );

    test(
      'When login() failed, it returns an exception error',
      () async {
        when(mockAuthenticationService.logIn(any)).thenThrow(MockDioError());

        result() => authenticationRepository.logIn(
              email: "email",
              password: "password",
            );

        expect(result, throwsA(isA<NetworkExceptions>()));
      },
    );

    test(
      "When refresh token success, it returns new token data",
      () async {
        final json =
            await FileUtils.loadFile('test/mock_responses/login_data.json');
        final loginResponse = LoginResponse.fromJson(json);

        when(mockAuthenticationService.getAuthToken(any))
            .thenAnswer((_) async => loginResponse);

        final loginModel = await authenticationRepository.getAuthToken(
            refreshToken: 'refreshToken');

        expect(loginModel.accessToken,
            "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c");
        expect(loginModel.tokenType, 'Bearer');
        expect(loginModel.refreshToken,
            '3zJz2oW0njxlj_I3ghyUBF7ZfdQKYXd2n0ODlMkAjHc');
      },
    );

    test(
      "When refresh token failed, it emits network exception",
      () async {
        final json =
            await FileUtils.loadFile('test/mock_responses/login_data.json');

        when(mockAuthenticationService.getAuthToken(any))
            .thenThrow(MockDioError());
        result() =>
            authenticationRepository.getAuthToken(refreshToken: 'refreshToken');
        expect(result, throwsA(isA<NetworkExceptions>()));
      },
    );
  });
}
