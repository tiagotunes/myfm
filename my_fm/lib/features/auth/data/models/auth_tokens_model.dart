import 'package:my_fm/features/auth/domain/entities/auth_tokens.dart';

class AuthTokensModel extends AuthTokens {
  AuthTokensModel({required super.accessToken, required super.refreshToken});

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
