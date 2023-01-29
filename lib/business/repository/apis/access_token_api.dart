import '../local_database/hive_db_util.dart';

class AccessTokenAPI {
  AccessTokenAPI._();
  static Future<bool> getAccessToken(
      String accessRequest) async {
    try {
      await Future.delayed(const Duration(seconds: 5));

      HiveDB.addAccessToken("accessTokenResponse.accessToke");
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
