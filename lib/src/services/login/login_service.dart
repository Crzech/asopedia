import 'dart:convert';
import 'package:asopedia/src/models/user/user_info.dart';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/user/user.dart';
import 'package:asopedia/src/util/login_exception.dart';
import 'package:asopedia/src/util/user_preferences.dart';

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

  static Future<UserInfo> getUserInfo(userId) async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.get(
      Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/users/$userId', { 'context': 'edit' }),
      headers: <String, String> {
        'Content-Type': 'application/json; charsest=UTF-8',
        'Authorization': 'Bearer ${_prefs.token}'
      }
    );

    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw LoginException('Lo sentimos, ha ocurrido un error desconocido');
    }
  }
  
  static bool isUserConfirmed(UserInfo userInfo) => userInfo.firstName.isNotEmpty && userInfo.lastName.isNotEmpty;
  
  static Future<UserInfo> saveUser(String firstName, String lastName, String password) async {
    UserPreferences _prefs = UserPreferences();
    var payload = jsonDecode(ascii.decode(base64.decode(base64.normalize(_prefs.token.split('.')[1]))));
    final String userId = payload['data']['user']['id'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${_prefs.token}',
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/users/$userId'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'first_name': firstName,
        'last_name': lastName,
        'password': password
      })
    );

    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw LoginException('Lo sentimos, ha ocurrido un error desconocido');
    }
  }
}
