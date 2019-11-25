import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/status_code.dart';

class Api {
  static const endpoint = 'http://ec2-52-87-34-66.compute-1.amazonaws.com';

  var client = http.Client();

  /// Create Account
  ///
  /// Creates new user with email and password

  Future createUser(String email, String password) async {
    var body = {"email": email, "password": password};

    var response = await client.post('$endpoint/users/create', body: body);
    print('Create User Response: ${response.body}');
  }

  /// Login
  ///
  /// Logs in the App using email and password

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

  /// Get Profile
  ///
  /// Returns your profile information

  Future<Profile> getProfile() async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};

    final response = await client.patch('$endpoint/profile', headers: headers);
    print('Profile Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }

  /// Get Profile with ID
  ///
  /// Returns the profile information of a specific ID

  Future<Profile> getProfileWithId(String id) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};

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

  /// Update Profile
  ///
  /// Updates your profile information

  Future<Profile> updateProfile(Profile profile) async {
    String token = await Storage.getToken();

    var body = profile.toJson();
    var headers = {"Authorization": token};
    var response =
        await client.patch('$endpoint/profile', body: body, headers: headers);
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

  /// Get Instruments
  ///
  /// Returns a list of instruments available

  Future<Instruments> getInstruments() async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};

    var response = await client.get('$endpoint/profile/tags', headers: headers);
    print('Instruments Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        print(json);
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

  Future<SearchResponse> getSearchProfiles(SearchRequest searchRequest) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};
    var parameters = '?';

    bool isFirstParameter = true;

    var name = searchRequest.getName();
    if (name != "") {
      parameters += isFirstParameter ? 'name=$name' : '&name=$name';
      isFirstParameter = false;
    }

    var instruments = searchRequest.getInstrumentsString();
    if (instruments != "") {
      parameters += isFirstParameter
          ? 'instruments=$instruments'
          : '&instruments=$instruments';
      isFirstParameter = false;
    }

    var maxDistance = searchRequest.getMaxDistance();
    if (maxDistance != "") {
      parameters += isFirstParameter
          ? 'maxDistance=$maxDistance'
          : '&maxDistance=$maxDistance';
      isFirstParameter = false;
    }

    var request = '$endpoint/search/profile$parameters';

    var response = await client.get(request, headers: headers);
    print('Search Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        print(json);
        return SearchResponse.fromJson(json);
      case StatusCode.clientError:
        var json = jsonDecode(response.body);
        var error = json["message"];
        return Future.error('Error', StackTrace.fromString(error));
      case StatusCode.serverError:
        var json = jsonDecode(response.body);
        var error = json["message"];
        return Future.error('Error', StackTrace.fromString(error));
      default:
        return SearchResponse();
    }
  }
}
