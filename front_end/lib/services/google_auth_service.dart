import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_end/models/users.dart';

class GoogleAuthService {
  static const String baseUrl = "http://10.0.2.2:8000";

  static Future<User?> fetchUserWithToken(String token) async{
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}