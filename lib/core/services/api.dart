import 'package:http/http.dart' as http;
import 'package:sounds_good/core/services/storage.dart';

class Api {
  static const endpoint = 'http://ec2-52-87-34-66.compute-1.amazonaws.com';

  var client = http.Client();

  Future createUser(String email, String password) async {
    var body = {"email": email, "password": password};

    var response = await client.post('$endpoint/users/create', body: body);
    print(response.body);
  }

  Future<bool> login(String email, String password) async {
    var body = {"email": email, "password": password};

    var response = await client.post('$endpoint/users/login', body: body);
    print('Login response: ${response.body}');

    switch (response.statusCode) {
      case 200:
        Storage.saveUserId(response.headers["id"]);
        Storage.saveToken(response.headers["authorization"]);

        return true;
      default:
        return false;
    }
  }
}
