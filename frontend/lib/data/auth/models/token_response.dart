// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenResponse {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory TokenResponse.fromMap(Map<String, dynamic> map) {
    return TokenResponse(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: map['expiresIn'] as int,
    );
  }

  factory TokenResponse.fromJson(String source) =>
      TokenResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
