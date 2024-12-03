import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';
  static String? accessToken;

  // Save the access token
  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
    print('Access token saved: $accessToken');
  }

  // Retrieve the access token
  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    print('Retrieved access token: $accessToken');
    return accessToken;
  }

  // Check if the user is logged in
  static bool isLoggedIn() {
    return accessToken != null;
  }

  // Clear user data
  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_accessTokenKey);
    accessToken = null;
    print('User data cleared');
  }

  // Save additional user data (optional)
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(userData));
  }

  // Retrieve user data (optional)
  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(_userDataKey);
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }
}
