import 'package:equatable/equatable.dart';
import 'package:flutter_survey/api/response/login_response.dart';

class LoginModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final int createdAt;

  const LoginModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [accessToken, tokenType, expiresIn, refreshToken, createdAt];

  factory LoginModel.fromResponse(LoginResponse response) {
    return LoginModel(
      accessToken: response.accessToken ?? "",
      tokenType: response.tokenType ?? "",
      expiresIn: response.expiresIn ?? 0,
      refreshToken: response.refreshToken ?? "",
      createdAt: response.createdAt ?? 0,
    );
  }
}
