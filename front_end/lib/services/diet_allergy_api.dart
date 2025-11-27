import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/utils/secure_storage.dart';

class DietAllergyAPI {
  static const baseUrl = "http://10.0.2.2:8000";

  static Future<Map<String, dynamic>?> save(Map<String, dynamic> data) async {
    final token = await SecureStorage.getToken();
    if (token == null) return null;

    final res = await http.post(
      Uri.parse("$baseUrl/diet-allergy/save"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>?> get() async {
    final token = await SecureStorage.getToken();
    if (token == null) return null;

    final res = await http.get(
      Uri.parse("$baseUrl/diet-allergy/get"),
      headers: {"Authorization": "Bearer $token"},
    );
    return jsonDecode(res.body);
  }
}
