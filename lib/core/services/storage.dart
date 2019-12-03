import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final manager = FlutterSecureStorage();

  // Save user ID for profile

  static void saveUserId(String id) async {
    await manager.write(key: "Id", value: id);
  }

  // Save user token for authentication

  static void saveToken(String token) async {
    await manager.write(key: "Token", value: token);
  }

  // Get user ID

  static Future<String> getUserId() async {
    String token = await manager.read(key: "Id");

    return token;
  }

  // Get user token

  static Future<String> getToken() async {
    String token = await manager.read(key: "Token");

    return token;
  }
}
             