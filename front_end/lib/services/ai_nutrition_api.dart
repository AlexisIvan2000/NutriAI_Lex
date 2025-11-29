import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/utils/secure_storage.dart';

class AiNutritionAPI {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<Map<String, dynamic>> generatePlan() async {
    final token = await SecureStorage.getToken();

    final res = await http.post(
      Uri.parse("$baseUrl/ai/weekly-plan"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    final data = jsonDecode(res.body);
    return data;
  }
}
