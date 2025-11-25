import 'package:flutter/material.dart';
import 'package:front_end/models/users.dart';
import 'package:front_end/utils/secure_storage.dart';
import 'package:front_end/services/auth_api.dart';

class AuthService extends ChangeNotifier {
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  User? user;
  String? token;
  bool isLoading = false;

  Future<void> loadSession() async {
    token = await SecureStorage.getToken();
    user = await SecureStorage.getUser();
    notifyListeners();
  }

  bool get isLoggedIn => user != null && token != null;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final ok = await AuthAPI.login(email, password);

    isLoading = false;

    if (ok) {
      token = await SecureStorage.getToken();
      user = await SecureStorage.getUser();
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await AuthAPI.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  Future<void> loginWithGoogle(String jwtToken, User userFromGoogle) async {
    token = jwtToken;
    user = userFromGoogle;

    await SecureStorage.saveToken(jwtToken);
    await SecureStorage.saveUser(userFromGoogle);

    notifyListeners();
  }

  Future<void> logout() async {
    await SecureStorage.clearAll();
    user = null;
    token = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return await AuthAPI.resetPassword(email: email, newPassword: newPassword);
  }
}
