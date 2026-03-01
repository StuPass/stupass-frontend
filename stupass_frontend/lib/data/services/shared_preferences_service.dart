import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // ---------------------------------------------------------
  // ACCESS TOKEN
  // ---------------------------------------------------------
  Future<void> saveAccessToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(_accessTokenKey);
    } else {
      await prefs.setString(_accessTokenKey, token);
    }
  }

  Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // ---------------------------------------------------------
  // REFRESH TOKEN
  // ---------------------------------------------------------
  Future<void> saveRefreshToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(_refreshTokenKey);
    } else {
      await prefs.setString(_refreshTokenKey, token);
    }
  }

  Future<String?> fetchRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }
}