import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/my_band.dart';
import 'package:sounds_good/core/models/notification.dart';
import 'package:sounds_good/core/models/notification_response.dart';
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

  /* Create User */

  Future<bool> createUser({String email, String password}) async {
    var body = {"email": email, "password": password};
    var response = await client.post('$endpoint/users/create', body: body);

    //print('Create User Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return false;
    }
  }

  /* Log-in User */

  Future<bool> login(String email, String password) async {
    var body = {"email": email, "password": password};
    var response = await client.post('$endpoint/users/login', body: body);

    print('Login Response: ${response.body}');

    Profile profile = Profile();

    switch (response.statusCode) {
      case 200:
        Storage.saveUserId(response.headers["id"]);
        Storage.saveToken(response.headers["authorization"]);
        
        // We need to store invitations and followers from own profile
        // to be able to Follow or Unfollow a member, 
        // or to know if a invitation sent is still pending;

        getProfile().then((res){
          profile = res;
          
        var ownProfileFolllowres = jsonEncode(profile.followers);
        var ownProfileInvitations =  jsonEncode(profile.invitations);
          
        Storage.saveFollowers(ownProfileFolllowres);
        Storage.saveInvitations(ownProfileInvitations);
        });
        
        return true;
      default:
        print('Login failed: ${response.reasonPhrase}');
        return false;
    }
  }

  /* Get Profile */

  Future<Profile> getProfile() async {
    String token = await Storage.getToken();

    //print('Token: $token');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    final response = await client.get('$endpoint/profile', headers: headers);

    //print('Profile Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }

  /* Get My Band */

  Future<MyBand> getMyBand(int limit, int offset) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};
    var parameters = '?';

    parameters += 'limit=$limit&offset=$offset';

    final request = '$endpoint/profile/my-band' + parameters;
    print('Search Request: $request');

    final response = await client.get(request, headers: headers);
    print('My-Band Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        print(json);
        return MyBand.fromJson(json);
      case StatusCode.clientError:
      case StatusCode.serverError:
      default:
        return MyBand();
    }
  }

  /* Get Profile with ID */

  Future<Profile> getProfileWithId(String id) async {
    String token = await Storage.getToken();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await client.get('$endpoint/profile/$id', headers: headers);

    print('Profile ID Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        print(response.statusCode);
        print(response.reasonPhrase);
        return Profile();
    }
  }

  /* Get Local with ID */

  Future<Local> getLocalWithId(String id) async {
    String token = await Storage.getToken();

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await client.get('$endpoint/local/$id', headers: headers);

    // print('Local ID Response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Local.fromJson(json);
      default:
        print(response.statusCode);
        print(response.reasonPhrase);
        return Local();
    }
  }

  /* Update Profile Information */

  Future<Profile> updateProfile(Profile profile) async {
    String token = await Storage.getToken();

    var body = json.encode(profile.toJson());

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };

    final response =
        await client.patch('$endpoint/profile', headers: headers, body: body);
    switch (response.statusCode) {
      case 200:
        var json = jsonDecode(response.body);
        return Profile.fromJson(json);
      default:
        return Profile();
    }
  }

  /* Update Profile Photo */

  updateAvatar(String filePath) async {
    var response = await uploadPhoto('$endpoint/profile/avatar', filePath);
    //final respStr = await response.stream.bytesToString();
    switch (response.statusCode) {
      case 200:
        //  print(respStr);

        break;
      default:
        print(response.statusCode);
        print(response.reasonPhrase);
        break;
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

  /* Get List of Available Instruments */

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

  /* Get Search Response for Members or Profiles */

  Future<SearchResponse> getSearchItems(
      SearchRequest searchRequest, SearchType type) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};
    var parameters = '?';

    var limit = searchRequest.getLimit();
    var offset = searchRequest.getOffset();

    parameters += 'limit=$limit&offset=$offset';

    var name = searchRequest.getName();
    if (name != "") {
      parameters += '&name=$name';
    }

    var maxDistance = searchRequest.getMaxDistance();
    if (maxDistance != "") {
      parameters += '&maxDistance=$maxDistance';
    }

    var endpointSearch = "";

    switch (type) {
      case SearchType.Members:
        var instruments = searchRequest.getInstrumentsString();
        if (instruments != "") {
          parameters += '&instruments=$instruments';
        }
        endpointSearch = '/profile';
        break;
      case SearchType.Locals:
        var price = searchRequest.getPrice();
        if (price != "") {
          parameters += '&price=$price';
        }
        endpointSearch = '/local';
        break;
    }

    var request = '$endpoint/search$endpointSearch' + parameters;
    print('Search Request: $request');

    var response = await client.get(request, headers: headers);
    print('Search Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        //print(json);
        return SearchResponse.fromJson(json, type);
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

  /* Get Notifications */

  Future<NotificationResponse> getNotifications(int limit, int offset) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};
    var parameters = '?';

    parameters += 'limit=$limit&offset=$offset';

    final response =
        await client.get('$endpoint/notification$parameters', headers: headers);

    //print('Notification Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        //print(json);
        return NotificationResponse.fromJson(json);
      case StatusCode.clientError:
      case StatusCode.serverError:
      default:
        return NotificationResponse();
    }
  }

  Future<MemberNotification> redeemNotification(String id) async {
    String token = await Storage.getToken();

    var headers = {"Authorization": token};

    final response =
        await client.get('$endpoint/notification/redeem/$id', headers: headers);

    print('Redeem Response: ${response.body}');

    StatusCode statusCode = getStatusCode(response.statusCode);

    switch (statusCode) {
      case StatusCode.success:
        var json = jsonDecode(response.body);
        return MemberNotification.fromJson(json);
      case StatusCode.clientError:
      case StatusCode.serverError:
      default:
        return MemberNotification();
    }
  }
}
