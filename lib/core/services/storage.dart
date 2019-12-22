import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final manager = FlutterSecureStorage();

  // Save user ID for profile

  static void saveUserId(String id) async {
    if (id != null) {
      await manager.write(key: "Id", value: id);
    }
  }

  // Save user token for authentication

  static void saveToken(String token) async {
    await manager.write(key: "Token", value: token);
  }

  // Save Available Instruments
  static void saveAvailableInstruments(String instrumentsList) async {
    await manager.write(key: "Available_Instruments", value: instrumentsList);
  }

  // Get Available Instruments
  static Future<String> getAvailableInstruments() async {
    String availableInstruments =
        await manager.read(key: "Available_Instruments");

    return availableInstruments;
  }

  // Save Followers and Invitations
  static void saveFollowers(String followersList) async {
    await manager.write(key: "Followers", value: followersList);
  }

  static void saveInvitations(String invitationsList) async {
    await manager.write(key: "Invitations", value: invitationsList);
  }

  // Get Followers and Invitations

  static Future<String> getFollowers() async {
    String followers = await manager.read(key: "Followers");

    return followers;
  }

  static Future<String> getInvitations() async {
    String invitations = await manager.read(key: "Invitations");

    return invitations;
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

  // LogOut
  static void logOut() async {
    await manager.deleteAll();
  }
}
