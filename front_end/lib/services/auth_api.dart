import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/models/users.dart';
import 'package:front_end/utils/secure_storage.dart';


class AuthAPI {
  static const String baseUrl = "http://10.0.2.2:8000";


  static Future<bool> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      await SecureStorage.saveToken(data["access_token"]);

      
      await getCurrentUser();

      return true;
    }
    return false;
  }

 
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(res.body);

    return {
      "success": res.statusCode == 200,
      "message": data["message"] ?? data["detail"] ?? "Erreur inconnue"
    };
  }

  static Future<User?> getCurrentUser() async {
    final token = await SecureStorage.getToken();
    if (token == null) return null;

    final res = await http.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final user = User.fromJson(data);
      await SecureStorage.saveUser(user);
      return user;
    }

    return null;
  }

  static Future<void> logout() async {
    await SecureStorage.clearAll();
  }
}