import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/utils/secure_storage.dart';

class NutritionAPI {
  static const baseUrl = "http://10.0.2.2:8000";

  static Future<Map<String, dynamic>?> getSummary() async {
    final token = await SecureStorage.getToken();
    if (token == null) return null;

    final res = await http.get(
      Uri.parse("$baseUrl/nutrition/summary"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    return null;
  }

  static Future<Map<String, dynamic>?> updateCalorieIntake({
    required int calories,
    required int proteins,
    required int carbs,
    required int fats,
  }) async {
    final token = await SecureStorage.getToken();
    if (token == null) return {"success": false, "message": "User not logged in"};

    final res = await http.post(
      Uri.parse("$baseUrl/nutrition/update"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "calories": calories,
        "proteins": proteins,
        "carbs": carbs,
        "fats": fats,
      }),
    );

    final data = jsonDecode(res.body);
    return {
      "success": res.statusCode == 200,
      "message": data["message"] ?? "Unknown error",
    };
  }
}
