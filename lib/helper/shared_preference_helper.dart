import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sera/backend/server_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sharedPreferences;

@immutable
class SharedPreferenceHelper {
  static const String _USER = 'SharedPreferenceHelper.user';
  static const String _USER_TYPE = 'SharedPreferenceHelper.userType';
  static const String _ACCESS_TOKEN = 'SharedPreferenceHelper.accessToken';

  static SharedPreferenceHelper? _instance;

  const SharedPreferenceHelper._();

  static SharedPreferenceHelper instance() {
    _instance ??= const SharedPreferenceHelper._();
    return _instance!;
  }

  static Future<void> initializeSharedPreferences() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  bool get isUserLoggedIn => _sharedPreferences?.containsKey(_USER) ?? false;

  // Method to save user type
  Future<void> setUserType(String userType) async =>
      _sharedPreferences?.setString(_USER_TYPE, userType);

  // Method to retrieve user type
  String? getUserType() => _sharedPreferences?.getString(_USER_TYPE);

  Future<void> saveAccessToken(String accessToken) async {
    _sharedPreferences?.setString(_ACCESS_TOKEN, accessToken);
  }

  Future<String?> getAccessToken() async {
    return _sharedPreferences?.getString(_ACCESS_TOKEN);
  }

  Future<void> insertUser(UserDataModel user) async {
    final userSerialization = json.encode(user);
    _sharedPreferences?.setString(_USER, userSerialization);
  }

  Future<UserDataModel?> get user async {
    final userSerialization = _sharedPreferences?.getString(_USER);
    if (userSerialization == null) return null;
    try {
      return UserDataModel.fromJson(json.decode(userSerialization));
    } catch (_) {
      return null;
    }
  }

  Future<void> clear() async => _sharedPreferences?.clear();
}
