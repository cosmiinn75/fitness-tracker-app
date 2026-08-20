import 'package:fitness_mvp/helper/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {

  final FlutterSecureStorage secureStorage;

  TokenStorage({required this.secureStorage});

  Future<void> saveTokens(String accessToken , String refreshToken) async{
    await secureStorage.write(key: AppConstants.accessTokenKey, value: accessToken);
    await secureStorage.write(key: AppConstants.refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async{
    return await secureStorage.read(key: AppConstants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async{
    return await secureStorage.read(key: AppConstants.refreshTokenKey);
  }


  Future<void> deleteTokens() async {
    await secureStorage.delete(
      key: AppConstants.accessTokenKey,
    );

    await secureStorage.delete(
      key: AppConstants.refreshTokenKey,
    );
  }



}