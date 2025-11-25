import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import  'package:front_end/models/users.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<void> clearToken() async {
    await storage.delete(key: "token");
  }

 
  static Future<void> saveUser(User user) async {
    final jsonUser = jsonEncode(user.toJson());
    await storage.write(key: "user", value: jsonUser);
  }

  static Future<User?> getUser() async {
    final data = await storage.read(key: "user");
    if (data == null) return null;
    return User.fromJson(jsonDecode(data));
  }

  static Future<void> clearUser() async {
    await storage.delete(key: "user");
  }

 
  static Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
