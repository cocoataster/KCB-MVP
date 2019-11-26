import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/status_code.dart';

class Api {
  static const endpoint = 'http://ec2-52-87-34-66.compute-1.amazonaws.com';

  var client = http.Client();

  Future createUser(String email, String password) async {
    var body = {"email": email, "password": password};
    var response = await client.post('$endpoint/users/create', body: body);
    
    print('Create User Response: ${response.body}');
  }


  Future<bool> login(String email, String password) async {
    var body = {"email": email, "password": password};
    var response = await client.post('$endpoint/users/login', body: body);
    
    print('Login Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        Storage.saveUserId(response.headers["id"]);
        Storage.saveToken(response.headers["authorization"]);
        return true;
      default:
        return false;
    }
  }


  Future<Profile> getProfile() async {
    String token = await Storage.getToken();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    final response = await client.get('$endpoint/profile', headers: headers);
    print('Profile Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }


  Future<Profile> getProfileWithId(String id) async {
    String token = await Storage.getToken();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await client.post('$endpoint/profile/$id', headers: headers);
    print('Profile ID Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }


  Future<Profile> updateProfile(Profile profile) async {
    String token = await Storage.getToken();

    var body = json.encode(profile.toJson());

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    print('_');
    print('Body to send: $body');

    final response =
        await client.patch('$endpoint/profile', headers: headers, body: body);

    print('_');
    print('Profile Update Response: ${response.body}');
    

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }

 /// Update Avatar
  ///
  /// Updates your profile picture

  Future<Profile> updateAvatar(String filePath) async {
    var response = await uploadPhoto('$endpoint/profile', filePath);
    print('Profile Update Avatar Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }

  Future uploadPhoto(String url, String filePath) async {
    var uri = Uri.parse(url);
    String token = await Storage.getToken();
    final mediaType = MediaType('application', 'x-tar');

    var request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = token;
    request.files.add(await http.MultipartFile.fromPath('photo', filePath,
        contentType: mediaType));

    var response = await request.send();

    return response;
  }

  // Get the available instruments list from server
  Future<Instruments> getInstruments() async {
    String token = await Storage.getToken();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var response = await client.get('$endpoint/profile/tags', headers: headers);

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        return Instruments.fromJson(json);
      case StatusCode.clientError:
        var json = jsonDecode(response.body);
        var error = json["message"];
        return Future.error('Error', StackTrace.fromString(error));
      case StatusCode.serverError:
        var json = jsonDecode(response.body);
        var error = json["message"];
        return Future.error('Error', StackTrace.fromString(error));
      default:
        return Instruments();
    }
  }
}
