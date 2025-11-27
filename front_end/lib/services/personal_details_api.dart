import 'dart:convert';
import 'package:front_end/models/datas.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/utils/secure_storage.dart';

class PersonalDetailsAPI {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<Map<String, dynamic>> savePersonalDetails(
    int userId,
    PersonalDetailsInput details,
  ) async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      return {"success": false, "message": "User not logged in"};
    }

  
    final double weightKg = details.weightLbs * 0.453592;
    final double heightCm = ((details.heightFeet * 12) + details.heightInches) * 2.54;

    final body = {
      "user_id": userId,
      "age": details.age,
      "weight": weightKg,
      "height": heightCm,
      "gender": details.gender,
      "activity_level": details.activityLevel,
      "goal": details.goal,
    };

    final response = await http.post(
      Uri.parse("$baseUrl/personal-details/save"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(body),
    );

    final resData = jsonDecode(response.body);

    return {
      "success": response.statusCode == 200,
      "message": 
      resData["message"] ?? 
      resData["detail"] ??
      resData["status"] ?? 
      "An unexpected error occurred",
    };
  }

  static Future<Map<String, dynamic>> getPersonalDetails(int userId) async {
    final token = await SecureStorage.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/personal-details/get/$userId"),
      headers: {"Authorization": "Bearer $token"},
    );
    final resData = jsonDecode(response.body);
    return resData;
  }

  static Future<Map<String, dynamic>> generateCalories(int userId, PersonalDetailsInput details) async {
  final token = await SecureStorage.getToken();
  final response = await http.post(
    Uri.parse("$baseUrl/calories/generate/$userId"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    },
    body: jsonEncode(details.toJson(userId)),
  );

  return jsonDecode(response.body);
}

}
