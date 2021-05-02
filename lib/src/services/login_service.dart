import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/user.dart';
import 'package:asopedia/src/util/login_exception.dart';

class LoginService {
  static Future<User> authUser(username, password) async {
    final response = await http.post(
      Uri.https('sgc.asopedia.com', 'wp-json/jwt-auth/v1/token'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      })
    );
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 403) {
      throw LoginException('Hemos fallado en autenticar al usuario');
    } else {
      throw Exception('Unknown error');
    }
  }
}
