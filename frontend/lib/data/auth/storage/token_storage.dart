import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens({ required Map<String, dynamic> tokens }) async {
    await _storage.write(key: _accessTokenKey, value: tokens[_accessTokenKey]);
    await _storage.write(key: _refreshTokenKey, value: tokens[_refreshTokenKey]);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<void> updateAccessToken({ required String accessToken}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
