import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/utils/secure_storage.dart';

class DietAllergyAPI {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<Map<String, dynamic>> save({
    required String diet,
    required List<String> allergies,
  }) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return {"success": false, "message": "User not logged in"};
    }

    final res = await http.post(
      Uri.parse("$baseUrl/diet-allergy/save"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "diet": diet,
        "allergies": allergies,
      }),
    );

    final data = jsonDecode(res.body);
    return data is Map<String, dynamic>
        ? data
        : {"success": false, "message": "Unexpected server response"};
  }

  static Future<Map<String, dynamic>?> get() async {
    final token = await SecureStorage.getToken();
    if (token == null) return null;

    final res = await http.get(
      Uri.parse("$baseUrl/diet-allergy/get"),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(res.body);
    return data is Map<String, dynamic> ? data : null;
  }
}
