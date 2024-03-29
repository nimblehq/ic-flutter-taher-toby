import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  final String grantType;
  final String clientId;
  final String clientSecret;
  final String refreshToken;

  RefreshTokenRequest({
    required this.grantType,
    required this.clientId,
    required this.clientSecret,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
