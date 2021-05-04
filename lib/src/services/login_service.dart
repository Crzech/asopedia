import 'dart:convert';
import 'package:asopedia/src/models/user_info.dart';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/user.dart';
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
  
  static Future<bool> isUserConfirmed2(userId) async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.get(
      Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/users/$userId'),
      headers: <String, String> {
        'Content-Type': 'application/json; charsest=UTF-8',
        'Authorization': 'Bearer ${_prefs.token}'
      }
    );

    if (response.statusCode == 200) {
      final userInfo = UserInfo.fromJson(jsonDecode(response.body));
      return userInfo.firstName.isNotEmpty && userInfo.lastName.isNotEmpty;
    } else {
      print('pasando ${response.statusCode}');
      throw Exception('Lo sentimos, ha ocurrido un error desconocido');
    }
  }
  
  

  static bool isUserConfirmed(userId) {
    return false;
  }

}
